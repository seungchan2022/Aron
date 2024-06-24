import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - LikeList

public enum LikeList: String {
  case wishList = "WishList"
  case seenList = "SeenList"
}

// MARK: - MyListReducer

@Reducer
public struct MyListReducer {

  // MARK: Lifecycle

  public init(
    pageID: String = UUID().uuidString,
    sideEffect: MyListSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Public

  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID

    public var isShowingConfirmation = false

    public var selectedLikeList: LikeList = .wishList
    public var itemList: MovieEntity.List = .init()
    public var fetchItemList: FetchState.Data<MovieEntity.List?> = .init(isLoading: false, value: .none)

    public var fetchIsWish: FetchState.Data<Bool> = .init(isLoading: false, value: false)
    public var fetchIsSeen: FetchState.Data<Bool> = .init(isLoading: false, value: false)

    public init(id: UUID = UUID()) {
      self.id = id
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItemList

    case updateIsWish(MovieEntity.MovieDetail.MovieCard.Response)
    case updateIsSeen(MovieEntity.MovieDetail.MovieCard.Response)

    case fetchItemList(Result<MovieEntity.List, CompositeErrorRepository>)

    case fetchIsWish(Result<Bool, CompositeErrorRepository>)
    case fetchIsSeen(Result<Bool, CompositeErrorRepository>)

    case sortedByReleaseDate
    case sortedByRating
    case sortedByPopularity

    case routeToDetail(MovieEntity.MovieDetail.MovieCard.Response)

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

      case .getItemList:
        state.fetchItemList.isLoading = true
        return sideEffect
          .getItemList()
          .cancellable(pageID: pageID, id: CancelID.requestItemList, cancelInFlight: true)

      case .updateIsWish(let item):
        state.fetchIsWish.isLoading = true
        return sideEffect.updateIsWish(item)
          .cancellable(pageID: pageID, id: CancelID.requestIsWish, cancelInFlight: true)

      case .updateIsSeen(let item):
        state.fetchIsSeen.isLoading = true
        return sideEffect.updateIsSeen(item)
          .cancellable(pageID: pageID, id: CancelID.requestIsSeen, cancelInFlight: true)

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

      case .fetchIsWish(let result):
        state.fetchIsWish.isLoading = false
        switch result {
        case .success(let item):
          state.fetchIsWish.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchIsSeen(let result):
        state.fetchIsSeen.isLoading = false
        switch result {
        case .success(let item):
          state.fetchIsSeen.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .sortedByReleaseDate:
        state.itemList = sideEffect.sortedByReleaseDate(state.itemList)
        return .none

      case .sortedByRating:
        state.itemList = sideEffect.sortedByRating(state.itemList)
        return .none

      case .sortedByPopularity:
        state.itemList = sideEffect.sortedByPopularity(state.itemList)
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

  // MARK: Internal

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItemList
    case requestIsWish
    case requestIsSeen
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: MyListSideEffect
}
