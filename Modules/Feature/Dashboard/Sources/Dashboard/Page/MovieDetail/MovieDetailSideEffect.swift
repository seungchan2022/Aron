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

  var routeToCastList: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.cast.rawValue,
          items: item.serializedCredit()),
        isAnimated: true)
    }
  }

  var routeToCrewList: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.crew.rawValue,
          items: item.serializedCredit()),
        isAnimated: true)
    }
  }

  var routeToSimilarMovie: (MovieEntity.MovieDetail.SimilarMovie.Response.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serializedSimilarMovie()),
        isAnimated: true)
    }
  }

  var routeToSimilarMovieList: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.similar.rawValue,
          items: item.serializedSimilarMovieList()),
        isAnimated: true)
    }
  }

  var routeToRecommendedMovie: (MovieEntity.MovieDetail.RecommendedMovie.Response.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serilaizedRecommendedMovie()),
        isAnimated: true)
    }
  }

  var routeToRecommendedMovieList: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.recommended.rawValue,
          items: item.serializedRecommendedMovieList()),
        isAnimated: true)
    }
  }

  var routeToOtherPoster: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.fullSheet(
        linkItem: .init(
          path: Link.Dashboard.Path.otherPoster.rawValue,
          items: item.serializedOtherPoster()),
        isAnimated: false,
        prefersLargeTitles: false)
    }
  }
}

extension MovieEntity.MovieDetail.Review.Response {
  fileprivate func serializedReview() -> MovieEntity.MovieDetail.Review.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.MovieDetail.MovieCard.Response {
  fileprivate func serializedCredit() -> MovieEntity.MovieDetail.Credit.Request {
    .init(movieID: self.id)
  }
}

extension MovieEntity.MovieDetail.Credit.CastItem {
  fileprivate func serializedCast() -> MovieEntity.Person.Info.Request {
    .init(personID: id)
  }
}

extension MovieEntity.MovieDetail.Credit.CrewItem {
  fileprivate func serializedCrew() -> MovieEntity.Person.Info.Request {
    .init(personID: id)
  }
}

extension MovieEntity.MovieDetail.SimilarMovie.Response.Item {
  fileprivate func serializedSimilarMovie() -> MovieEntity.MovieDetail.SimilarMovie.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.MovieDetail.RecommendedMovie.Response.Item {
  fileprivate func serilaizedRecommendedMovie() -> MovieEntity.MovieDetail.RecommendedMovie.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.MovieDetail.MovieCard.Response {
  fileprivate func serializedOtherPoster() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }

  fileprivate func serializedSimilarMovieList() -> MovieEntity.MovieDetail.SimilarMovie.Request {
    .init(movieID: id)
  }

  fileprivate func serializedRecommendedMovieList() -> MovieEntity.MovieDetail.RecommendedMovie.Request {
    .init(movieID: id)
  }
}
