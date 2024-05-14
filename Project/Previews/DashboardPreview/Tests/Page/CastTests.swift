import ComposableArchitecture
import Dashboard
import Domain
import Foundation
import Platform
import XCTest

// MARK: - CastTests

final class CastTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.fetchCastItem, .init(isLoading: false, value: .none))))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getCastItem_succes_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.Credit.Request = .init(movieID: 2)

    let responseMock: MovieEntity.MovieDetail.Credit.Response = ResponseMock().response.credit.successValue

    await sut.store.send(.getCastItem(requestMock)) { state in
      state.fetchCastItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchCastItem) { state in
      state.fetchCastItem.isLoading = false
      state.fetchCastItem.value = responseMock
    }
  }

  @MainActor
  func test_getCastItem_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.Credit.Request = .init(movieID: 2)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getCastItem(requestMock)) { state in
      state.fetchCastItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchCastItem) { state in
      state.fetchCastItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_routeToProfile_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.Credit.CastItem = ResponseMock().response.credit.successValue.castItemList.first!

    await sut.store.send(.routeToProfile(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }
}

extension CastTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: CastReducer.State = .init(castItem: .init(movieID: 2))) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          CastReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<CastReducer.State, CastReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDetailUseCaseStub.Response = .init()
    init() { }
  }
}
