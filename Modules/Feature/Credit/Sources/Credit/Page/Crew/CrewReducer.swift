import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
public struct CrewReducer {

  // MARK: Lifecycle

  public init(
    pageID: String = UUID().uuidString,
    sideEffect: CrewSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Public

  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID

    public let crewItem: MovieEntity.MovieDetail.Credit.Request
    public var fetchCrewItem: FetchState.Data<MovieEntity.MovieDetail.Credit.Response?> = .init(isLoading: false, value: .none)

    public init(
      id: UUID = UUID(),
      crewItem: MovieEntity.MovieDetail.Credit.Request)
    {
      self.id = id
      self.crewItem = crewItem
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getCrewItem(MovieEntity.MovieDetail.Credit.Request)
    case fetchCrewItem(Result<MovieEntity.MovieDetail.Credit.Response, CompositeErrorRepository>)

    case routeToProfile(MovieEntity.MovieDetail.Credit.CrewItem)

    case throwError(CompositeErrorRepository)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getCrewItem(let requestModel):
        state.fetchCrewItem.isLoading = true
        return sideEffect.crew(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestCrew, cancelInFlight: true)

      case .fetchCrewItem(let result):
        state.fetchCrewItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchCrewItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToProfile(let item):
        sideEffect.routeToProfile(item)
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Internal

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestCrew
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: CrewSideEffect
}
