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
    { item in
      .publisher {
        useCase.movieDetailUseCase.movieCard(item)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchDetailItem)
      }
    }
  }

  var review: (MovieEntity.MovieDetail.Review.Request) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieDetailUseCase.review(item)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchReviewItem)
      }
    }
  }

  var credit: (MovieEntity.MovieDetail.Credit.Request) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieDetailUseCase.credit(item)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchCreditItem)
      }
    }
  }

  var similarMovie: (MovieEntity.MovieDetail.SimilarMovie.Request) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieDetailUseCase.similarMovie(item)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchSimilarMovieItem)
      }
    }
  }

  var recommendedMovie: (MovieEntity.MovieDetail.RecommendedMovie.Request) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieDetailUseCase.recommendedMovie(item)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchRecommendedMovieItem)
      }
    }
  }
}
