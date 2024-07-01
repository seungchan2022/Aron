import ComposableArchitecture
import Domain
import Foundation
import Movie
import Platform
import XCTest

// MARK: - GenreTests

final class GenreTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.set(\.fetchItem, .init(isLoading: false, value: .none)))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getItem_success_case() async {
    let sut = SUT()

    let mock: MovieEntity.MovieDetail.MovieCard.GenreItem = .init(id: 2, name: "test")

    let responseMock: MovieEntity.Discover.Genre.Response = ResponseMock().response.genre.successValue

    await sut.store.send(.getItem(mock)) { state in
      state.fetchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
      state.fetchItem.value = responseMock
    }
  }

  @MainActor
  func test_getItem_failure_case() async {
    let sut = SUT()

    let mock: MovieEntity.MovieDetail.MovieCard.GenreItem = .init(id: 2, name: "test")

    sut.container.movieDiscoverUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getItem(mock)) { state in
      state.fetchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_routeToDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Discover.Genre.Item = ResponseMock().response.genre.successValue.itemList.first!

    await sut.store.send(.routeToDetail(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

}

extension GenreTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: GenreReducer.State = .init(item: .init(id: 2, name: "test"))) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          GenreReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<GenreReducer.State, GenreReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDiscoverUseCaseStub.Response = .init()
    init() { }
  }
}
