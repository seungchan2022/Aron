import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MovieDetailSideEffect

struct MovieDetailSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension MovieDetailSideEffect {
  var detail: (MovieEntity.MovieDetail.MovieCard.Request) -> Effect<MovieDetailReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.movieCard(request)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchDetailItem)
      }
    }
  }

  var review: (MovieEntity.MovieDetail.Review.Request) -> Effect<MovieDetailReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.review(request)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchReviewItem)
      }
    }
  }

  var credit: (MovieEntity.MovieDetail.Credit.Request) -> Effect<MovieDetailReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.credit(request)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchCreditItem)
      }
    }
  }

  var similarMovie: (MovieEntity.MovieDetail.SimilarMovie.Request) -> Effect<MovieDetailReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.similarMovie(request)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchSimilarMovieItem)
      }
    }
  }

  var recommendedMovie: (MovieEntity.MovieDetail.RecommendedMovie.Request) -> Effect<MovieDetailReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.recommendedMovie(request)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchRecommendedMovieItem)
      }
    }
  }
  
  var routeToReview: (MovieEntity.MovieDetail.Review.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.review.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.Review.Response {
  fileprivate func serialized() -> MovieEntity.MovieDetail.Review.Request {
    .init(movieID: self.id)
  }
}
