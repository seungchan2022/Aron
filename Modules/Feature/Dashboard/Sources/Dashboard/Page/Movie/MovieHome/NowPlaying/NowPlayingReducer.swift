import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - NowPlayingReducer

@Reducer
public struct NowPlayingReducer {

  // MARK: Lifecycle

  public init(
    pageID: String = UUID().uuidString,
    sideEffect: NowPlayingSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID

    public var itemList: [MovieEntity.Movie.NowPlaying.Item] = []

    public var fetchItem: FetchState.Data<MovieEntity.Movie.NowPlaying.Response?> = .init(isLoading: false, value: .none)

    public init(id: UUID = UUID()) {
      self.id = id
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem

    case fetchItem(Result<MovieEntity.Movie.NowPlaying.Response, CompositeErrorRepository>)

    case routeToDetail(MovieEntity.Movie.NowPlaying.Item)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItemList
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
          .cancellable(pageID: pageID, id: CancelID.requestItemList, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = state.itemList + item.itemList
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
  private let sideEffect: NowPlayingSideEffect
}
