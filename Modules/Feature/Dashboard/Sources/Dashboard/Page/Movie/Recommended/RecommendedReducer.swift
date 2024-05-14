import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
public struct RecommendedReducer {

  // MARK: Lifecycle

  public init(
    pageID: String = UUID().uuidString,
    sideEffect: RecommendedSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Public

  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID

    public let item: MovieEntity.MovieDetail.RecommendedMovie.Request

    public var fetchItem: FetchState.Data<MovieEntity.MovieDetail.RecommendedMovie.Response?> = .init(
      isLoading: false,
      value: .none)

    public init(
      id: UUID = UUID(),
      item: MovieEntity.MovieDetail.RecommendedMovie.Request)
    {
      self.id = id
      self.item = item
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MovieEntity.MovieDetail.RecommendedMovie.Request)
    case fetchItem(Result<MovieEntity.MovieDetail.RecommendedMovie.Response, CompositeErrorRepository>)

    case routeToDetail(MovieEntity.MovieDetail.RecommendedMovie.Response.Item)

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

      case .getItem(let request):
        state.fetchItem.isLoading = true
        return sideEffect.recommended(request)
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToDetail(let item):
        sideEffect.routeToDetail(item)
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Internal

  enum CancelID: CaseIterable, Equatable {
    case teardown
    case requestItem
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: RecommendedSideEffect
}
