import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct MovieDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: MovieDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable {
    let id: UUID
    let item: MovieEntity.MovieDetail.MovieCard.Request
    var fetchDetailItem: FetchState.Data<MovieEntity.MovieDetail.MovieCard.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      item: MovieEntity.MovieDetail.MovieCard.Request)
    {
      self.id = id
      self.item = item
    }
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getDetail
    case fetchDetailItem(Result<MovieEntity.MovieDetail.MovieCard.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestDetail
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

      case .getDetail:
        state.fetchDetailItem.isLoading = true
        return sideEffect.detail(state.item)
          .cancellable(pageID: pageID, id: CancelID.requestDetail, cancelInFlight: true)

      case .fetchDetailItem(let result):
        state.fetchDetailItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchDetailItem.value = item
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
  private let sideEffect: MovieDetailSideEffect
}
