import ComposableArchitecture
import Dashboard
import Domain
import Foundation
import Platform
import XCTest

// MARK: - MyListTests

final class MyListTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.itemList, .init())))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getItemList_success_case() async {
    let sut = SUT()

    let wishMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue
    let seenMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    let responseMock: MovieEntity.List = .init(
      wishList: [wishMock],
      seenList: [seenMock])

    /// - Note: 해당 리스트에 들어가도록
    sut.container.movieListUseCaseFake.reset(
      store: .init(
        wishList: [wishMock],
        seenList: [seenMock]))

    await sut.store.send(.getItemList) { state in
      state.fetchItemList.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchItemList) { state in
      state.fetchItemList.isLoading = false
      state.fetchItemList.value = responseMock
      state.itemList = responseMock
    }
  }

  @MainActor
  func test_fetchItemList_failure_case() async {
    let sut = SUT()

    await sut.store.send(.fetchItemList(.failure(.invalidTypeCasting)))

    await sut.scheduler.advance()

    await sut.store.receive(\.throwError)

    XCTAssertEqual(sut.container.toastViewActionMock.event.sendErrorMessage, 1)
  }

  @MainActor
  func test_sortedByReleaseDate_case() async {
    let sut = SUT()

//    await sut.store.send(.sortedByReleaseDate)

    let wishMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue
    let seenMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue
    
    let responseMock: MovieEntity.List = .init(
      wishList: [wishMock],
      seenList: [seenMock])
    
    
    /// - Note: 해당 리스트에 들어가도록
    sut.container.movieListUseCaseFake.reset(
      store: .init(
        wishList: [wishMock],
        seenList: [seenMock]))
    
    
    await sut.store.send(.sortedByReleaseDate) { state in
      state.itemList = .init(
        wishList: responseMock.wishList.sorted(by: { $0.releaseDate > $1.releaseDate}),
        seenList: responseMock.seenList.sorted(by: { $0.releaseDate > $1.releaseDate})
      )
    }
  }

  @MainActor
  func test_sortedByRating_case() async {
    let sut = SUT()

    await sut.store.send(.sortedByRating)
  }

  @MainActor
  func test_sortedByPopularity_case() async {
    let sut = SUT()

    await sut.store.send(.sortedByPopularity)
  }

  @MainActor
  func test_routeToDetail_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.routeToDetail(responseMock))

    XCTAssertEqual(
      sut.container.linkNavigatorMock
        .event.next,
      1)
  }
}

extension MyListTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: MyListReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          MyListReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<MyListReducer.State, MyListReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDetailUseCaseStub.Response = .init()
    init() { }
  }
}
