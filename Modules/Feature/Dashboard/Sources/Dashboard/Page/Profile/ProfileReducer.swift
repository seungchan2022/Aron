import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct ProfileReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: ProfileSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    let item: MovieEntity.Person.Request

    var fetchItem: FetchState.Data<MovieEntity.Person.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      item: MovieEntity.Person.Request)
    {
      self.id = id
      self.item = item
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MovieEntity.Person.Request)

    case fetchItem(Result<MovieEntity.Person.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItem
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getItem(let requestModel):
        state.fetchItem.isLoading = true
        return sideEffect.item(requestModel)
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

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: ProfileSideEffect
}
