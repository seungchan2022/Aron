import ComposableArchitecture
import Dashboard
import Domain
import Foundation
import Platform
import XCTest

// MARK: - OtherPosterTests

final class OtherPosterTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_bidning() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.fetchItem, .init(isLoading: false, value: .none))))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getItem_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.MovieCard.Request = .init(movieID: 2)

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.getItem(requestMock)) { state in
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

    let requestMock: MovieEntity.MovieDetail.MovieCard.Request = .init(movieID: 2)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getItem(requestMock)) { state in
      state.fetchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_routeToBack_case() async {
    let sut = SUT()

    await sut.store.send(.routeToBack)

    XCTAssertEqual(sut.container.linkNavigatorMock.event.close, 1)
  }

}

extension OtherPosterTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: OtherPosterReducer.State = .init(item: .init(movieID: 2))) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          OtherPosterReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<OtherPosterReducer.State, OtherPosterReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDetailUseCaseStub.Response = .init()
    init() { }
  }
}
