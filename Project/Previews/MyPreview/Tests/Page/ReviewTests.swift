import ComposableArchitecture
import Domain
import Foundation
import My
import Platform
import XCTest

// MARK: - ReviewTests

final class ReviewTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.fetchReviewItem, .init(isLoading: false, value: .none))))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getReview_success_case() async {
    let sut = SUT()

    let mock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    let responseMock: MovieEntity.MovieDetail.Review.Response = ResponseMock().response.review.successValue

    await sut.store.send(.getReview(mock)) { state in
      state.fetchReviewItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchReviewItem) { state in
      state.fetchReviewItem.isLoading = false
      state.fetchReviewItem.value = responseMock
    }
  }

  @MainActor
  func test_getReview_failure_case() async {
    let sut = SUT()

    let mock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getReview(mock)) { state in
      state.fetchReviewItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchReviewItem) { state in
      state.fetchReviewItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }
}

extension ReviewTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: ReviewReducer.State = .init(reviewItem: ResponseMock().response.movieCard.successValue)) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          ReviewReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<ReviewReducer.State, ReviewReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDetailUseCaseStub.Response = .init()
    init() { }
  }
}
