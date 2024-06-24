import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MovieDetailSideEffect

public struct MovieDetailSideEffect {
  public let useCase: MyEnvironmentUsable
  public let main: AnySchedulerOf<DispatchQueue>
  public let navigator: RootNavigatorType

  public init(
    useCase: MyEnvironmentUsable,
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

  var isWishLike: (MovieEntity.MovieDetail.MovieCard.Response) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieListUseCase.getIsWishLike()
          .map {
            $0.wishList.first(where: { $0 == item }) != .none
          }
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchIsWish)
      }
    }
  }

  var updateIsWish: (MovieEntity.MovieDetail.MovieCard.Response) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieListUseCase.saveWishList(item)
          .map {
            $0.wishList.first(where: { $0 == item }) != .none
          }
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchIsWish)
      }
    }
  }

  var isSeenLike: (MovieEntity.MovieDetail.MovieCard.Response) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieListUseCase.getIsSeenLike()
          .map {
            $0.seenList.first(where: { $0 == item }) != .none
          }
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchIsSeen)
      }
    }
  }

  var updateIsSeen: (MovieEntity.MovieDetail.MovieCard.Response) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieListUseCase.saveSeenList(item)
          .map {
            $0.seenList.first(where: { $0 == item }) != .none
          }
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchIsSeen)
      }
    }
  }

  var routeToGenre: (MovieEntity.MovieDetail.MovieCard.GenreItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.genre.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToKeyword: (MovieEntity.MovieDetail.MovieCard.KeywordItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.keyword.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToReview: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.review.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToCastItem: (MovieEntity.MovieDetail.Credit.CastItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Person.Path.profile.rawValue,
          items: item.serializedCast()),
        isAnimated: true)
    }
  }

  var routeToCrewItem: (MovieEntity.MovieDetail.Credit.CrewItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Person.Path.profile.rawValue,
          items: item.serializedCrew()),
        isAnimated: true)
    }
  }

  var routeToCastList: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Person.Path.cast.rawValue,
          items: item.serializedCredit()),
        isAnimated: true)
    }
  }

  var routeToCrewList: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Person.Path.crew.rawValue,
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

extension MovieEntity.MovieDetail.MovieCard.Response {
  fileprivate func serializedReview() -> MovieEntity.MovieDetail.Review.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.MovieDetail.MovieCard.Response {
  fileprivate func serializedCredit() -> MovieEntity.MovieDetail.Credit.Request {
    .init(movieID: id)
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
