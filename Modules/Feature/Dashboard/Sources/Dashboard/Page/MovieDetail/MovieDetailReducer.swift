import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct MovieDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: MovieDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable {

    // MARK: Lifecycle

    init(
      id: UUID = UUID(),
      item: MovieEntity.MovieDetail.MovieCard.Request,
      reviewItem: MovieEntity.MovieDetail.Review.Request,
      creditItem: MovieEntity.MovieDetail.Credit.Request,
      similarMovieItem: MovieEntity.MovieDetail.SimilarMovie.Request,
      recommendedMovieItem: MovieEntity.MovieDetail.RecommendedMovie.Request)
    {
      self.id = id
      self.item = item
      self.reviewItem = reviewItem
      self.creditItem = creditItem
      self.similarMovieItem = similarMovieItem
      self.recommendedMovieItem = recommendedMovieItem
    }

    // MARK: Internal

    var isShowingConfirmation = false
    var isShowingReadMore = false

    let id: UUID
    let item: MovieEntity.MovieDetail.MovieCard.Request
    let reviewItem: MovieEntity.MovieDetail.Review.Request
    let creditItem: MovieEntity.MovieDetail.Credit.Request
    let similarMovieItem: MovieEntity.MovieDetail.SimilarMovie.Request
    let recommendedMovieItem: MovieEntity.MovieDetail.RecommendedMovie.Request

    var fetchDetailItem: FetchState.Data<MovieEntity.MovieDetail.MovieCard.Response?> = .init(isLoading: false, value: .none)
    var fetchReviewItem: FetchState.Data<MovieEntity.MovieDetail.Review.Response?> = .init(isLoading: false, value: .none)
    var fetchCreditItem: FetchState.Data<MovieEntity.MovieDetail.Credit.Response?> = .init(isLoading: false, value: .none)
    var fetchSimilarMovieItem: FetchState.Data<MovieEntity.MovieDetail.SimilarMovie.Response?> = .init(
      isLoading: false,
      value: .none)
    var fetchRecommendedMovieItem: FetchState.Data<MovieEntity.MovieDetail.RecommendedMovie.Response?> = .init(
      isLoading: false,
      value: .none)

    var fetchIsWish: FetchState.Data<Bool> = .init(isLoading: false, value: false)

    var fetchIsSeen: FetchState.Data<Bool> = .init(isLoading: false, value: false)
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getDetail(MovieEntity.MovieDetail.MovieCard.Request)
    case getReview(MovieEntity.MovieDetail.Review.Request)
    case getCredit(MovieEntity.MovieDetail.Credit.Request)
    case getSimilarMovie(MovieEntity.MovieDetail.SimilarMovie.Request)
    case getRecommendedMovie(MovieEntity.MovieDetail.RecommendedMovie.Request)

    case getIsWishLike(MovieEntity.MovieDetail.MovieCard.Response?)
    case updateIsWish(MovieEntity.MovieDetail.MovieCard.Response)

    case getIsSeenLike(MovieEntity.MovieDetail.MovieCard.Response?)
    case updateIsSeen(MovieEntity.MovieDetail.MovieCard.Response)

    case fetchDetailItem(Result<MovieEntity.MovieDetail.MovieCard.Response, CompositeErrorRepository>)
    case fetchReviewItem(Result<MovieEntity.MovieDetail.Review.Response, CompositeErrorRepository>)
    case fetchCreditItem(Result<MovieEntity.MovieDetail.Credit.Response, CompositeErrorRepository>)
    case fetchSimilarMovieItem(Result<MovieEntity.MovieDetail.SimilarMovie.Response, CompositeErrorRepository>)
    case fetchRecommendedMovieItem(Result<MovieEntity.MovieDetail.RecommendedMovie.Response, CompositeErrorRepository>)

    case fetchIsWish(Result<Bool, CompositeErrorRepository>)
    case fetchIsSeen(Result<Bool, CompositeErrorRepository>)

    case routeToGenre(MovieEntity.MovieDetail.MovieCard.GenreItem)

    case routeToReview(MovieEntity.MovieDetail.Review.Response)
    case routeToCastItem(MovieEntity.MovieDetail.Credit.CastItem)
    case routeToCrewItem(MovieEntity.MovieDetail.Credit.CrewItem)
    case routeToCastList(MovieEntity.MovieDetail.MovieCard.Response)
    case routeToCrewList(MovieEntity.MovieDetail.MovieCard.Response)
    case routeToSimilarMovie(MovieEntity.MovieDetail.SimilarMovie.Response.Item)

    case routeToSimilarMovieList(MovieEntity.MovieDetail.MovieCard.Response)

    case routeToRecommendedMovie(MovieEntity.MovieDetail.RecommendedMovie.Response.Item)
    case routeToRecommendedMovieList(MovieEntity.MovieDetail.MovieCard.Response)

    case routeToOtherPoster(MovieEntity.MovieDetail.MovieCard.Response)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestDetail
    case requestReview
    case requestCredit
    case reqeustSimilarMovie
    case requestRecommendedMovie
    case requestIsWish
    case requestIsSeen
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getDetail(let requestModel):
        state.fetchDetailItem.isLoading = true
        return sideEffect.detail(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestDetail, cancelInFlight: true)

      case .getReview(let requestModel):
        state.fetchReviewItem.isLoading = true
        return sideEffect.review(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestReview, cancelInFlight: true)

      case .getCredit(let requestModel):
        state.fetchCreditItem.isLoading = true
        return sideEffect.credit(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestCredit, cancelInFlight: true)

      case .getSimilarMovie(let requestModel):
        state.fetchSimilarMovieItem.isLoading = true
        return sideEffect.similarMovie(requestModel)
          .cancellable(pageID: pageID, id: CancelID.reqeustSimilarMovie, cancelInFlight: true)

      case .getRecommendedMovie(let requestModel):
        state.fetchRecommendedMovieItem.isLoading = true
        return sideEffect.recommendedMovie(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestRecommendedMovie, cancelInFlight: true)

      case .getIsWishLike(let item):
        guard let item else { return .none }
        state.fetchIsWish.isLoading = true
        return sideEffect.isWishLike(item)
          .cancellable(pageID: pageID, id: CancelID.requestIsWish, cancelInFlight: true)

      case .updateIsWish(let item):
        state.fetchIsWish.isLoading = true
        return sideEffect.updateIsWish(item)
          .cancellable(pageID: pageID, id: CancelID.requestIsWish, cancelInFlight: true)

      case .getIsSeenLike(let item):
        guard let item else { return .none }
        state.fetchIsSeen.isLoading = true
        return sideEffect.isSeenLike(item)
          .cancellable(pageID: pageID, id: CancelID.requestIsSeen, cancelInFlight: true)

      case .updateIsSeen(let item):
        state.fetchIsSeen.isLoading = true
        return sideEffect.updateIsSeen(item)
          .cancellable(pageID: pageID, id: CancelID.requestIsSeen, cancelInFlight: true)

      case .fetchDetailItem(let result):
        state.fetchDetailItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchDetailItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchReviewItem(let result):
        state.fetchReviewItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchReviewItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
      case .fetchCreditItem(let result):
        state.fetchCreditItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchCreditItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSimilarMovieItem(let result):
        state.fetchSimilarMovieItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchSimilarMovieItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchRecommendedMovieItem(let result):
        state.fetchRecommendedMovieItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchRecommendedMovieItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchIsWish(let result):
        state.fetchIsWish.isLoading = false
        switch result {
        case .success(let item):
          state.fetchIsWish.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchIsSeen(let result):
        state.fetchIsSeen.isLoading = false
        switch result {
        case .success(let item):
          state.fetchIsSeen.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToGenre(let item):
        sideEffect.routeToGenre(item)
        return .none

      case .routeToReview(let item):
        sideEffect.routeToReview(item)
        return .none

      case .routeToCastItem(let item):
        sideEffect.routeToCastItem(item)
        return .none

      case .routeToCrewItem(let item):
        sideEffect.routeToCrewItem(item)
        return .none

      case .routeToCastList(let item):
        sideEffect.routeToCastList(item)
        return .none

      case .routeToCrewList(let item):
        sideEffect.routeToCrewList(item)
        return .none

      case .routeToSimilarMovie(let item):
        sideEffect.routeToSimilarMovie(item)
        return .none

      case .routeToSimilarMovieList(let item):
        sideEffect.routeToSimilarMovieList(item)
        return .none

      case .routeToRecommendedMovie(let item):
        sideEffect.routeToRecommendedMovie(item)
        return .none

      case .routeToRecommendedMovieList(let item):
        sideEffect.routeToRecommendedMovieList(item)
        return .none

      case .routeToOtherPoster(let item):
        sideEffect.routeToOtherPoster(item)
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: MovieDetailSideEffect
}
