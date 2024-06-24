import ComposableArchitecture
import Domain
import Foundation
import My
import Platform
import XCTest

// MARK: - ProfileTests

final class ProfileTests: XCTestCase {
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
  func test_getItem_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.My.Info.Request = .init(MyID: 2)
    let responseMock: MovieEntity.My.Info.Response = ResponseMock().response.info.successValue

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

    let requestMock: MovieEntity.My.Info.Request = .init(MyID: 2)

    sut.container.MyUseCaseStub.type = .failure(.invalidTypeCasting)

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
  func test_getProfileImage_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.My.Image.Request = .init(MyID: 2)
    let responseMock: MovieEntity.My.Image.Response = ResponseMock().response.image.successValue

    await sut.store.send(.getProfileImage(requestMock)) { state in
      state.fetchProfileImage.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchProfileImage) { state in
      state.fetchProfileImage.isLoading = false
      state.fetchProfileImage.value = responseMock
    }
  }

  @MainActor
  func test_getProfileImage_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.My.Image.Request = .init(MyID: 2)

    sut.container.MyUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getProfileImage(requestMock)) { state in
      state.fetchProfileImage.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchProfileImage) { state in
      state.fetchProfileImage.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getMovieCreditItem_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.My.MovieCredit.Request = .init(MyID: 2)
    let responseMock: MovieEntity.My.MovieCredit.Response = ResponseMock().response.movieCredit.successValue

    await sut.store.send(.getMovieCreditItem(requestMock)) { state in
      state.fetchMovieCreditItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchMovieCreditItem) { state in
      state.fetchMovieCreditItem.isLoading = false
      state.fetchMovieCreditItem.value = responseMock
    }
  }

  @MainActor
  func test_getMovieCreditItem_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.My.MovieCredit.Request = .init(MyID: 2)

    sut.container.MyUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getMovieCreditItem(requestMock)) { state in
      state.fetchMovieCreditItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchMovieCreditItem) { state in
      state.fetchMovieCreditItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_routeToCastDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.My.MovieCredit.CastItem = (ResponseMock().response.movieCredit.successValue.castItemList.first)!

    await sut.store.send(.routeToCastDetail(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToCrewDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.My.MovieCredit.CrewItem = (ResponseMock().response.movieCredit.successValue.crewItemList.first)!

    await sut.store.send(.routeToCrewDetail(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }
}

extension ProfileTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: ProfileReducer.State = .init(
      item: .init(MyID: 2),
      profileImageItem: .init(MyID: 2),
      movieCreditItem: .init(MyID: 2)))
    {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          ProfileReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<ProfileReducer.State, ProfileReducer.Action>
  }

  struct ResponseMock {
    let response: MyUseCaseStub.Response = .init()
    init() { }
  }
}
