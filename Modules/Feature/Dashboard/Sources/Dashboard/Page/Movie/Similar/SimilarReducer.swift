import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct SimilarReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: SimilarSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    let item: MovieEntity.MovieDetail.SimilarMovie.Request

    var fetchItem: FetchState.Data<MovieEntity.MovieDetail.SimilarMovie.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      item: MovieEntity.MovieDetail.SimilarMovie.Request)
    {
      self.id = id
      self.item = item
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MovieEntity.MovieDetail.SimilarMovie.Request)
    case fetchItem(Result<MovieEntity.MovieDetail.SimilarMovie.Response, CompositeErrorRepository>)
    
    case routeToDetail(MovieEntity.MovieDetail.SimilarMovie.Response.Item)


    case throwError(CompositeErrorRepository)
  }

  enum CancelID: CaseIterable, Equatable {
    case teardown
    case requestItem
    case requestItemList
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

      case .getItem(let request):
        state.fetchItem.isLoading = true
        return sideEffect.similar(request)
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

  // MARK: Private

  private let pageID: String
  private let sideEffect: SimilarSideEffect
}
