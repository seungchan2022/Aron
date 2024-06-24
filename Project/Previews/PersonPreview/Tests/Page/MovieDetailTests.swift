import ComposableArchitecture
import Domain
import Foundation
import Person
import Platform
import XCTest

// MARK: - MovieDetailTests

final class MovieDetailTests: XCTestCase {

  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.fetchDetailItem, .init(isLoading: false, value: .none))))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_getDetail_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.MovieCard.Request = .init(movieID: 1)
    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.getDetail(requestMock)) { state in
      state.fetchDetailItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchDetailItem) { state in
      state.fetchDetailItem.isLoading = false
      state.fetchDetailItem.value = responseMock
    }
  }

  @MainActor
  func test_getDetail_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.MovieCard.Request = .init(movieID: 1)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getDetail(requestMock)) { state in
      state.fetchDetailItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchDetailItem) { state in
      state.fetchDetailItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getReview_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.Review.Request = .init(movieID: 1)
    let responseMock: MovieEntity.MovieDetail.Review.Response = ResponseMock().response.review.successValue

    await sut.store.send(.getReview(requestMock)) { state in
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

    let requestMock: MovieEntity.MovieDetail.Review.Request = .init(movieID: 1)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getReview(requestMock)) { state in
      state.fetchReviewItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchReviewItem) { state in
      state.fetchReviewItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getCredit_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.Credit.Request = .init(movieID: 1)
    let responseMock: MovieEntity.MovieDetail.Credit.Response = ResponseMock().response.credit.successValue

    await sut.store.send(.getCredit(requestMock)) { state in
      state.fetchCreditItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchCreditItem) { state in
      state.fetchCreditItem.isLoading = false
      state.fetchCreditItem.value = responseMock
    }
  }

  @MainActor
  func test_getCredit_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.Credit.Request = .init(movieID: 1)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getCredit(requestMock)) { state in
      state.fetchCreditItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchCreditItem) { state in
      state.fetchCreditItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getSimilarMovie_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.SimilarMovie.Request = .init(movieID: 1)
    let responseMock: MovieEntity.MovieDetail.SimilarMovie.Response = ResponseMock().response.similarMovie.successValue

    await sut.store.send(.getSimilarMovie(requestMock)) { state in
      state.fetchSimilarMovieItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSimilarMovieItem) { state in
      state.fetchSimilarMovieItem.isLoading = false
      state.fetchSimilarMovieItem.value = responseMock
    }
  }

  @MainActor
  func test_getSimilarMovie_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.SimilarMovie.Request = .init(movieID: 1)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getSimilarMovie(requestMock)) { state in
      state.fetchSimilarMovieItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSimilarMovieItem) { state in
      state.fetchSimilarMovieItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getRecommendedMovie_success_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.RecommendedMovie.Request = .init(movieID: 1)
    let responseMock: MovieEntity.MovieDetail.RecommendedMovie.Response = ResponseMock().response.recommendedMovie.successValue

    await sut.store.send(.getRecommendedMovie(requestMock)) { state in
      state.fetchRecommendedMovieItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchRecommendedMovieItem) { state in
      state.fetchRecommendedMovieItem.isLoading = false
      state.fetchRecommendedMovieItem.value = responseMock
    }
  }

  @MainActor
  func test_getRecommendedMovie_failure_case() async {
    let sut = SUT()

    let requestMock: MovieEntity.MovieDetail.RecommendedMovie.Request = .init(movieID: 1)

    sut.container.movieDetailUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.getRecommendedMovie(requestMock)) { state in
      state.fetchRecommendedMovieItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchRecommendedMovieItem) { state in
      state.fetchRecommendedMovieItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_getIsWishList_succes_case1() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 없음
    sut.container.movieListUseCaseFake.reset()

    await sut.store.send(.getIsWishLike(responseMock)) { state in
      state.fetchIsWish.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsWish) { state in
      state.fetchIsWish.isLoading = false
      state.fetchIsWish.value = false
    }
  }

  @MainActor
  func test_getIsWishList_succes_case2() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 있음 => 좋아요인 상태
    sut.container.movieListUseCaseFake.reset(store: .init(wishList: [responseMock]))

    await sut.store.send(.getIsWishLike(responseMock)) { state in
      state.fetchIsWish.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsWish) { state in
      state.fetchIsWish.isLoading = false
      state.fetchIsWish.value = true
    }
  }

  @MainActor
  func test_updateIsWish_succes_case1() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 없음
    sut.container.movieListUseCaseFake.reset()

    await sut.store.send(.updateIsWish(responseMock)) { state in
      state.fetchIsWish.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsWish) { state in
      state.fetchIsWish.isLoading = false
      /// - Note: 현재 아이템이 UnLike 상태인데 위에서 updateIsLike를 수행했으므로 Like인 상태(true)로 변경
      state.fetchIsWish.value = true
    }
  }

  @MainActor
  func test_updateIsWish_succes_case2() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 있음 => 좋아요인 상태
    sut.container.movieListUseCaseFake.reset(store: .init(wishList: [responseMock]))

    await sut.store.send(.updateIsWish(responseMock)) { state in
      state.fetchIsWish.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsWish) { state in
      state.fetchIsWish.isLoading = false
      /// - Note: 현재 아이템이 Like 상태인데 위에서 updateIsLike를 수행했으므로 UnLike인 상태(false) 로 변경
      state.fetchIsWish.value = false
    }
  }

  @MainActor
  func test_getIsSeenList_succes_case1() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 없음
    sut.container.movieListUseCaseFake.reset()

    await sut.store.send(.getIsSeenLike(responseMock)) { state in
      state.fetchIsSeen.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsSeen) { state in
      state.fetchIsSeen.isLoading = false
      state.fetchIsSeen.value = false
    }
  }

  @MainActor
  func test_getIsSeenList_succes_case2() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 있음 => 좋아요인 상태
    sut.container.movieListUseCaseFake.reset(store: .init(seenList: [responseMock]))

    await sut.store.send(.getIsSeenLike(responseMock)) { state in
      state.fetchIsSeen.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsSeen) { state in
      state.fetchIsSeen.isLoading = false
      state.fetchIsSeen.value = true
    }
  }

  @MainActor
  func test_updateIsSeen_succes_case1() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 없음
    sut.container.movieListUseCaseFake.reset()

    await sut.store.send(.updateIsSeen(responseMock)) { state in
      state.fetchIsSeen.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsSeen) { state in
      state.fetchIsSeen.isLoading = false
      /// - Note: 현재 아이템이 UnLike 상태인데 위에서 updateIsLike를 수행했으므로 Like인 상태(true)로 변경
      state.fetchIsSeen.value = true
    }
  }

  @MainActor
  func test_updateIsSeen_succes_case2() async {
    let sut = SUT()

    let responseMock: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    /// - Note: Like 리스트에 해당 아이템이 있음 => 좋아요인 상태
    sut.container.movieListUseCaseFake.reset(store: .init(seenList: [responseMock]))

    await sut.store.send(.updateIsSeen(responseMock)) { state in
      state.fetchIsSeen.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchIsSeen) { state in
      state.fetchIsSeen.isLoading = false
      /// - Note: 현재 아이템이 Like 상태인데 위에서 updateIsLike를 수행했으므로 UnLike인 상태(false) 로 변경
      state.fetchIsSeen.value = false
    }
  }

  @MainActor
  func test_fetchIsWish_failure_case() async {
    let sut = SUT()

    await sut.store.send(.fetchIsWish(.failure(.invalidTypeCasting)))

    await sut.scheduler.advance()

    await sut.store.receive(\.throwError)

    XCTAssertEqual(sut.container.toastViewActionMock.event.sendErrorMessage, 1)
  }

  @MainActor
  func test_fetchIsSeen_failure_case() async {
    let sut = SUT()

    await sut.store.send(.fetchIsSeen(.failure(.invalidTypeCasting)))

    await sut.scheduler.advance()

    await sut.store.receive(\.throwError)

    XCTAssertEqual(sut.container.toastViewActionMock.event.sendErrorMessage, 1)
  }

  @MainActor
  func test_routeToGenre_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.GenreItem = ResponseMock().response.movieCard.successValue.genreItemList.first!

    await sut.store.send(.routeToGenre(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToKeyword_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.KeywordItem = (
      ResponseMock().response.movieCard.successValue.keywordBucket
        .keywordItem?.first)!

    await sut.store.send(.routeToKeyword(pick))
  }

  @MainActor
  func test_routeToReview_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.routeToReview(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToCastItem_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.Credit.CastItem = ResponseMock().response.credit.successValue.castItemList.first!

    await sut.store.send(.routeToCastItem(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToCrewItem_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.Credit.CrewItem = ResponseMock().response.credit.successValue.crewItemList.first!

    await sut.store.send(.routeToCrewItem(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToCastList_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.routeToCastList(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToCrewList_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.routeToCrewList(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToSimilarMovie_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.SimilarMovie.Response.Item = ResponseMock().response.similarMovie.successValue.itemList
      .first!

    await sut.store.send(.routeToSimilarMovie(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToSimilarMovieList_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.routeToSimilarMovieList(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToRecommendedMovie_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.RecommendedMovie.Response.Item = ResponseMock().response.recommendedMovie.successValue
      .itemList.first!

    await sut.store.send(.routeToRecommendedMovie(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToRecommendedMovieList_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.routeToRecommendedMovieList(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }

  @MainActor
  func test_routeToOtherPoster_case() async {
    let sut = SUT()

    let pick: MovieEntity.MovieDetail.MovieCard.Response = ResponseMock().response.movieCard.successValue

    await sut.store.send(.routeToOtherPoster(pick))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.fullSheet, 1)
  }

}

extension MovieDetailTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: MovieDetailReducer.State = .init(
      item: .init(movieID: 1),
      reviewItem: .init(movieID: 1),
      creditItem: .init(movieID: 1),
      similarMovieItem: .init(movieID: 1),
      recommendedMovieItem: .init(movieID: 1)))
    {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          MovieDetailReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<MovieDetailReducer.State, MovieDetailReducer.Action>
  }

  struct ResponseMock {
    let response: MovieDetailUseCaseStub.Response = .init()
    init() { }
  }
}
