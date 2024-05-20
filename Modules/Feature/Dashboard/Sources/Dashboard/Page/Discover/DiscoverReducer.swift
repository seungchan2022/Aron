import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - DiscoverReducer

@Reducer
public struct DiscoverReducer {

  // MARK: Lifecycle

  public init(
    pageID: String = UUID().uuidString,
    sideEffect: DiscoverSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Public

  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID

    public var itemList: [MovieEntity.Discover.Movie.Item] = []

    public var fetchItem: FetchState.Data<MovieEntity.Discover.Movie.Response?> = .init(isLoading: false, value: .none)

    public init(id: UUID = UUID()) {
      self.id = id
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem

    case fetchItem(Result<MovieEntity.Discover.Movie.Response, CompositeErrorRepository>)

    case routeToDetail(MovieEntity.Discover.Movie.Item)

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
        return sideEffect
          .getItem(.init(page: page))
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

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
    case requestItem
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: DiscoverSideEffect
}

extension [MovieEntity.Discover.Movie.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }

    return new
  }
}
