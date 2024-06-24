import ComposableArchitecture
import Domain
import Foundation
import Person
import Platform
import XCTest

// MARK: - MovieListTests

final class MovieListTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.nowPlayingItemList, [])))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getNowPlayingItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Movie.NowPlaying.Response = ResponseMock().response.nowPlaying.successValue

    await sut.store.send(.getNowPlayingItem) { state in
      state.fetchNowPlayingItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchNowPlayingItem) { state in
      state.fetchNowPlayingItem.isLoading = false
      state.fetchNowPlayingItem.value = responseMock
      state.nowPlayingItemList = responseMock.itemList
    }
  }

  @MainActor
  func test_getNowPlayingItem_failure_case() async {
    let sut = SUT()

    sut.containr.movieUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getNowPlayingItem) { state in
      state.fetchNowPlayingItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchNowPlayingItem) { state in
      state.fetchNowPlayingItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getUpcomingItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Movie.Upcoming.Response = ResponseMock().response.upcoming.successValue

    await sut.store.send(.getUpcomingItem) { state in
      state.fetchUpcomingItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchUpcomingItem) { state in
      state.fetchUpcomingItem.isLoading = false
      state.fetchUpcomingItem.value = responseMock
      state.upcomingItemList = responseMock.itemList
    }
  }

  @MainActor
  func test_getUpcomingItem_failure_case() async {
    let sut = SUT()

    sut.containr.movieUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getUpcomingItem) { state in
      state.fetchUpcomingItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchUpcomingItem) { state in
      state.fetchUpcomingItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getTrendingItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Movie.Trending.Response = ResponseMock().response.trending.successValue

    await sut.store.send(.getTrendingItem) { state in
      state.fetchTrendingItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchTrendingItem) { state in
      state.fetchTrendingItem.isLoading = false
      state.fetchTrendingItem.value = responseMock
      state.trendingItemList = responseMock.itemList
    }
  }

  @MainActor
  func test_getTrendingItem_failure_case() async {
    let sut = SUT()

    sut.containr.movieUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getTrendingItem) { state in
      state.fetchTrendingItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchTrendingItem) { state in
      state.fetchTrendingItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getPopularItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Movie.Popular.Response = ResponseMock().response.popular.successValue

    await sut.store.send(.getPopularItem) { state in
      state.fetchPopularItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchPopularItem) { state in
      state.fetchPopularItem.isLoading = false
      state.fetchPopularItem.value = responseMock
      state.popularItemList = responseMock.itemList
    }
  }

  @MainActor
  func test_getPopularItem_failure_case() async {
    let sut = SUT()

    sut.containr.movieUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getPopularItem) { state in
      state.fetchPopularItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchPopularItem) { state in
      state.fetchPopularItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getTopRatedItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Movie.TopRated.Response = ResponseMock().response.topRated.successValue

    await sut.store.send(.getTopRatedItem) { state in
      state.fetchTopRatedItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchTopRatedItem) { state in
      state.fetchTopRatedItem.isLoading = false
      state.fetchTopRatedItem.value = responseMock
      state.topRatedItemList = responseMock.itemList
    }
  }

  @MainActor
  func test_getTopRatedItem_failure_case() async {
    let sut = SUT()

    sut.containr.movieUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getTopRatedItem) { state in
      state.fetchTopRatedItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchTopRatedItem) { state in
      state.fetchTopRatedItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getGenreItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Movie.GenreList.Response = ResponseMock().response.genreList.successValue

    await sut.store.send(.getGenreItem) { state in
      state.fetchGenreItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchGenreItem) { state in
      state.fetchGenreItem.isLoading = false
      state.fetchGenreItem.value = responseMock
      state.genreItemList = responseMock.itemList
    }
  }

  @MainActor
  func test_getGenreItem_failure_case() async {
    let sut = SUT()

    sut.containr.movieUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getGenreItem) { state in
      state.fetchGenreItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchGenreItem) { state in
      state.fetchGenreItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_routeToMovieHome_case() async {
    let sut = SUT()

    await sut.store.send(.routeToMovieHome)

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.back, 1)
  }

  @MainActor
  func test_routeToNowPlayingeDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Movie.NowPlaying.Item = ResponseMock().response.nowPlaying.successValue.itemList.first!

    await sut.store.send(.routeToNowPlayingDetail(pick))

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToUpcomingDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Movie.Upcoming.Item = ResponseMock().response.upcoming.successValue.itemList.first!

    await sut.store.send(.routeToUpcomingDetail(pick))

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToTrendingDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Movie.Trending.Item = ResponseMock().response.trending.successValue.itemList.first!

    await sut.store.send(.routeToTrendingDetail(pick))

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToPopularDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Movie.Popular.Item = ResponseMock().response.popular.successValue.itemList.first!

    await sut.store.send(.routeToPopularDetail(pick))

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToTopRatedDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Movie.TopRated.Item = ResponseMock().response.topRated.successValue.itemList.first!

    await sut.store.send(.routeToTopRatedDetail(pick))

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToGenreDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Movie.GenreList.Item = ResponseMock().response.genreList.successValue.itemList.first!

    await sut.store.send(.routeToGenreDetail(pick))

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToNowPlaying_case() async {
    let sut = SUT()

    await sut.store.send(.routeToNowPlaying)

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToUpcoming_case() async {
    let sut = SUT()

    await sut.store.send(.routeToUpcoming)

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToTrending_case() async {
    let sut = SUT()

    await sut.store.send(.routeToTrending)

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToPopular_case() async {
    let sut = SUT()

    await sut.store.send(.routeToPopular)

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToTopRated_case() async {
    let sut = SUT()

    await sut.store.send(.routeToTopRated)

    XCTAssertEqual(sut.containr.linkNavigatorMock.event.next, 1)
  }

}

extension MovieListTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: MovieListReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      containr = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          MovieListReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigator))
        })
    }

    // MARK: Internal

    let containr: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<MovieListReducer.State, MovieListReducer.Action>
  }

  struct ResponseMock {
    let response: MovieUseCaseStub.Response = .init()
    init() { }
  }
}
