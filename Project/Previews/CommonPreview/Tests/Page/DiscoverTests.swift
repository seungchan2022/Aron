import Common
import ComposableArchitecture
import Domain
import Foundation
import Platform
import XCTest

// MARK: - DiscoverTest

final class DiscoverTest: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.stroe.send(.binding(.set(\.itemList, [])))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.stroe.send(.teardown)
  }

  @MainActor
  func test_geItem_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Discover.Movie.Response = ResponseMock().response.movie.successValue

    await sut.stroe.send(.getItem) { state in
      state.fetchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.stroe.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
      state.fetchItem.value = responseMock
      state.itemList = responseMock.itemList
    }
  }

  @MainActor
  func test_getItem_failure_case() async {
    let sut = SUT()

    sut.container.movieDiscoverUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.stroe.send(.getItem) { state in
      state.fetchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.stroe.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
    }

    await sut.stroe.receive(\.throwError)
  }

  @MainActor
  func test_routeToDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Discover.Movie.Item = ResponseMock().response.movie.successValue.itemList.first!

    await sut.stroe.send(.routeToDetail(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.sheet, 1)
  }
}

extension DiscoverTest {
  struct SUT {

    // MARK: Lifecycle

    init(state: DiscoverReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      stroe = .init(
        initialState: state,
        reducer: {
          DiscoverReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let stroe: TestStore<DiscoverReducer.State, DiscoverReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDiscoverUseCaseStub.Response = .init()
    init() { }
  }
}
