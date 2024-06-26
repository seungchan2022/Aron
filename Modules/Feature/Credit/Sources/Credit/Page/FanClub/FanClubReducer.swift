import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - FanClubReducer

@Reducer
public struct FanClubReducer {

  // MARK: Lifecycle

  public init(
    pageID: String = UUID().uuidString,
    sideEffect: FanClubSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Public

  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID

    public var itemList: [MovieEntity.FanClub.Item] = []

    public var fetchItem: FetchState.Data<MovieEntity.FanClub.Response?> = .init(isLoading: false, value: .none)

    public init(id: UUID = UUID()) {
      self.id = id
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem
    case fetchItem(Result<MovieEntity.FanClub.Response, CompositeErrorRepository>)

    case routeToDetail(MovieEntity.FanClub.Item)

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

      case .getItem:
        let page = Int(state.itemList.count / 20) + 1
        state.fetchItem.isLoading = true
        return sideEffect.getItem(.init(page: page))
          .cancellable(pageID: pageID, id: CancelID.requestItemList, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = state.itemList.merge(item.itemList)
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

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItemList
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: FanClubSideEffect
}

extension [MovieEntity.FanClub.Item] {

  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }

    return new
  }
}
