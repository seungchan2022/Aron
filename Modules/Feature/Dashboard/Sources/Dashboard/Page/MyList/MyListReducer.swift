import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - LikeList

enum LikeList: String {
  case wishList = "WishList"
  case seenList = "SeenList"
}

// MARK: - MyListReducer

@Reducer
struct MyListReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: MyListSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    var isShowingConfirmation = false

    var selectedLikeList: LikeList = .wishList
    var itemList: MovieEntity.List = .init()
    var fetchItemList: FetchState.Data<MovieEntity.List?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItemList
    case fetchItemList(Result<MovieEntity.List, CompositeErrorRepository>)

    case routeToNewList
    case routeToDetail(MovieEntity.MovieDetail.MovieCard.Response)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
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

      case .getItemList:
        state.fetchItemList.isLoading = true
        return sideEffect.getItemList()
          .cancellable(pageID: pageID, id: CancelID.requestItemList, cancelInFlight: true)

      case .fetchItemList(let result):
        state.fetchItemList.isLoading = false
        switch result {
        case .success(let list):
          state.fetchItemList.value = list
          state.itemList = list
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToNewList:
        sideEffect.routeToNewList()
        return .none

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
  private let sideEffect: MyListSideEffect
}
