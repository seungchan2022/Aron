import ComposableArchitecture
import Domain
import Foundation
import Movie
import Platform
import XCTest

// MARK: - RecommendedTests

final class RecommendedTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.fetchItem, .init(isLoading: false, value: .none))))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getItem_succes_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.RecommendedMovie.Request = .init(movieID: 2)

    let responseMock: MovieEntity.MovieDetail.RecommendedMovie.Response = ResponseMock().response.recommendedMovie.successValue

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

    let requestMock: MovieEntity.MovieDetail.RecommendedMovie.Request = .init(movieID: 2)

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
  func test_routeToDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.RecommendedMovie.Response.Item = ResponseMock().response.recommendedMovie.successValue
      .itemList.first!

    await sut.store.send(.routeToDetail(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }
}

extension RecommendedTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: RecommendedReducer.State = .init(item: .init(movieID: 2))) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          RecommendedReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<RecommendedReducer.State, RecommendedReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDetailUseCaseStub.Response = .init()
    init() { }
  }
}
