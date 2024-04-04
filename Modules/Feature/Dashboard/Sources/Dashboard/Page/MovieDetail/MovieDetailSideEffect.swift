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
          items: item.serializedReview()),
        isAnimated: true)
    }
  }

  var routeToCastItem: (MovieEntity.MovieDetail.Credit.CastItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.profile.rawValue,
          items: item.serializedCast()),
        isAnimated: true)
    }
  }

  var routeToCrewItem: (MovieEntity.MovieDetail.Credit.CrewItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.profile.rawValue,
          items: item.serializedCrew()),
        isAnimated: true)
    }
  }

  var routeToCastList: (MovieEntity.MovieDetail.Credit.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.cast.rawValue,
          items: item.serializedCredit()),
        isAnimated: true)
    }
  }

  var routeToCrewList: (MovieEntity.MovieDetail.Credit.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.crew.rawValue,
          items: item.serializedCredit()),
        isAnimated: true)
    }
  }

  var routeToSimilarMovieList: () -> Void {
    {
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.similar.rawValue),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.Review.Response {
  fileprivate func serializedReview() -> MovieEntity.MovieDetail.Review.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.MovieDetail.Credit.Response {
  fileprivate func serializedCredit() -> MovieEntity.MovieDetail.Credit.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.MovieDetail.Credit.CastItem {
  fileprivate func serializedCast() -> MovieEntity.Person.Request {
    .init(personID: id)
  }
}

extension MovieEntity.MovieDetail.Credit.CrewItem {
  fileprivate func serializedCrew() -> MovieEntity.Person.Request {
    .init(personID: id)
  }
}
