import ComposableArchitecture
import Domain
import Foundation
import Movie
import Platform
import XCTest

// MARK: - NowPlayingTests

final class NowPlayingTests: XCTestCase {

  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.itemList, [])))
  }

  @MainActor
  func test_getItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Movie.NowPlaying.Response = ResponseMock().response.nowPlaying.successValue

    await sut.store.send(.getItem) { state in
      state.fetchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
      state.fetchItem.value = responseMock
      state.itemList = responseMock.itemList
    }
  }

  @MainActor
  func test_failure_success_case() async {
    let sut = SUT()

    sut.container.movieUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getItem) { state in
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

    let pick: MovieEntity.Movie.NowPlaying.Item = ResponseMock().response.nowPlaying.successValue.itemList.first!

    await sut.store.send(.routeToDetail(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

}

extension NowPlayingTests {
  struct SUT {

    // MARK: Lifecycle

//    init(state: NowPlayingReducer.State = .init()) {
//      let container = AppContainerMock.build()
//      let main = DispatchQueue.test
//
//      self.container = container
//      self.scheduler = main
//
//      self.store = .init(
//        initialState: state,
//        reducer: {
//          NowPlayingReducer(
//            sideEffect: .init(
//              useCase: container.dependency,
//              main: main.eraseToAnyScheduler(),
//              navigator: container.navigator))
//        })
//    }

    init(state: NowPlayingReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          NowPlayingReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<NowPlayingReducer.State, NowPlayingReducer.Action>
  }

  struct ResponseMock {
    let response: MovieUseCaseStub.Response = .init()
    init() { }
  }
}
