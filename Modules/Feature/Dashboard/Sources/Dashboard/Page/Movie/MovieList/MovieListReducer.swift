import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct MovieListReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: MovieListSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    var nowPlayingItemList: [MovieEntity.Movie.NowPlaying.Item] = []
    var upcomingItemList: [MovieEntity.Movie.Upcoming.Item] = []
    var trendingItemList: [MovieEntity.Movie.Trending.Item] = []
    var popularItemList: [MovieEntity.Movie.Popular.Item] = []
    var topRatedItemList: [MovieEntity.Movie.TopRated.Item] = []

    var fetchNowPlayingItem: FetchState.Data<MovieEntity.Movie.NowPlaying.Response?> = .init(isLoading: false, value: .none)
    var fetchUpcomingItem: FetchState.Data<MovieEntity.Movie.Upcoming.Response?> = .init(isLoading: false, value: .none)
    var fetchTrendingItem: FetchState.Data<MovieEntity.Movie.Trending.Response?> = .init(isLoading: false, value: .none)
    var fetchPopularItem: FetchState.Data<MovieEntity.Movie.Popular.Response?> = .init(isLoading: false, value: .none)
    var fetchTopRatedItem: FetchState.Data<MovieEntity.Movie.TopRated.Response?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getNowPlayingItem
    case getUpcomingItem
    case getTrendingItem
    case getPopularItem
    case getTopRatedItem

    case fetchNowPlayingItem(Result<MovieEntity.Movie.NowPlaying.Response, CompositeErrorRepository>)
    case fetchUpcomingItem(Result<MovieEntity.Movie.Upcoming.Response, CompositeErrorRepository>)
    case fetchTrendingItem(Result<MovieEntity.Movie.Trending.Response, CompositeErrorRepository>)
    case fetchPopularItem(Result<MovieEntity.Movie.Popular.Response, CompositeErrorRepository>)
    case fetchTopRatedItem(Result<MovieEntity.Movie.TopRated.Response, CompositeErrorRepository>)

    case routeToMovieHome

    case routeToNowPlayingDetail(MovieEntity.Movie.NowPlaying.Item)
    case routeToUpcomingDetail(MovieEntity.Movie.Upcoming.Item)
    case routeToTrendingDetail(MovieEntity.Movie.Trending.Item)
    case routeToPopularDetail(MovieEntity.Movie.Popular.Item)
    case routeToTopRatedDetail(MovieEntity.Movie.TopRated.Item)

    case routeToNowPlaying
    case routeToUpcoming

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestNowPlayingItem
    case requestUpcomingItem
    case requestTrendingItem
    case requestPopularItem
    case requestTopRatedItem
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

      case .getNowPlayingItem:
        state.fetchNowPlayingItem.isLoading = true
        return sideEffect.getNowPlayingItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestNowPlayingItem, cancelInFlight: true)

      case .getUpcomingItem:
        state.fetchUpcomingItem.isLoading = true
        return sideEffect.getUpcomingItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestUpcomingItem, cancelInFlight: true)

      case .getTrendingItem:
        state.fetchTrendingItem.isLoading = true
        return sideEffect.getTrendingItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestTrendingItem, cancelInFlight: true)

      case .getPopularItem:
        state.fetchPopularItem.isLoading = true
        return sideEffect.getPopularItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestPopularItem, cancelInFlight: true)

      case .getTopRatedItem:
        state.fetchTopRatedItem.isLoading = true
        return sideEffect.getTopRatedItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestTopRatedItem, cancelInFlight: true)

      case .fetchNowPlayingItem(let result):
        state.fetchNowPlayingItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchNowPlayingItem.value = item
          state.nowPlayingItemList = state.nowPlayingItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchUpcomingItem(let result):
        state.fetchUpcomingItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchUpcomingItem.value = item
          state.upcomingItemList = state.upcomingItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchTrendingItem(let result):
        state.fetchTrendingItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchTrendingItem.value = item
          state.trendingItemList = state.trendingItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchPopularItem(let result):
        state.fetchPopularItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchPopularItem.value = item
          state.popularItemList = state.popularItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchTopRatedItem(let result):
        state.fetchTopRatedItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchTopRatedItem.value = item
          state.topRatedItemList = state.topRatedItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToMovieHome:
        sideEffect.routeToMovieHome()
        return .none

      case .routeToNowPlayingDetail(let item):
        sideEffect.routeToNowPlayingDetail(item)
        return .none

      case .routeToUpcomingDetail(let item):
        sideEffect.routeToUpcomingDetail(item)
        return .none

      case .routeToTrendingDetail(let item):
        sideEffect.routeToTrendingDetail(item)
        return .none

      case .routeToPopularDetail(let item):
        sideEffect.routeToPopularDetail(item)
        return .none

      case .routeToTopRatedDetail(let item):
        sideEffect.routeToTopRatedDetail(item)
        return .none

      case .routeToNowPlaying:
        sideEffect.routeToNowPlaying()
        return .none

      case .routeToUpcoming:
        sideEffect.routeToUpcoming()
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: MovieListSideEffect
}
