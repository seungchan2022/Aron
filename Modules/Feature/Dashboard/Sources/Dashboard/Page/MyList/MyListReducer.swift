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

    public init(id: UUID = UUID()) {
      self.id = id
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItemList
    case fetchItemList(Result<MovieEntity.List, CompositeErrorRepository>)

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

      case .sortedByReleaseDate:
        state.itemList = .init(
          wishList: sideEffect.sortedByReleaseDate(state.itemList.wishList),
          seenList: sideEffect.sortedByReleaseDate(state.itemList.seenList))
        return .none

      case .sortedByRating:
        state.itemList = .init(
          wishList: sideEffect.sortedByRating(state.itemList.wishList),
          seenList: sideEffect.sortedByRating(state.itemList.seenList))
        return .none

      case .sortedByPopularity:
        state.itemList = .init(
          wishList: sideEffect.sortedByPopularity(state.itemList.wishList),
          seenList: sideEffect.sortedByPopularity(state.itemList.seenList))
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
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: MyListSideEffect
}
