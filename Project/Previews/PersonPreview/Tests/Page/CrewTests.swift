import ComposableArchitecture
import Domain
import Foundation
import Person
import Platform
import XCTest

// MARK: - CrewTests

final class CrewTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.fetchCrewItem, .init(isLoading: false, value: .none))))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getCrewItem_succes_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.Credit.Request = .init(movieID: 2)

    let responseMock: MovieEntity.MovieDetail.Credit.Response = ResponseMock().response.credit.successValue

    await sut.store.send(.getCrewItem(requestMock)) { state in
      state.fetchCrewItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchCrewItem) { state in
      state.fetchCrewItem.isLoading = false
      state.fetchCrewItem.value = responseMock
    }
  }

  @MainActor
  func test_getCrewItem_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.Credit.Request = .init(movieID: 2)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getCrewItem(requestMock)) { state in
      state.fetchCrewItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchCrewItem) { state in
      state.fetchCrewItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_routeToProfile_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.Credit.CrewItem = ResponseMock().response.credit.successValue.crewItemList.first!

    await sut.store.send(.routeToProfile(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }
}

extension CrewTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: CrewReducer.State = .init(crewItem: .init(movieID: 2))) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          CrewReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<CrewReducer.State, CrewReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDetailUseCaseStub.Response = .init()
    init() { }
  }
}
