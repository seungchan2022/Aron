import Combine
import Domain

// MARK: - MovieDetailUseCasePlatform

public struct MovieDetailUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.themoviedb.org/3/movie") {
    self.baseURL = baseURL
  }
}

// MARK: MovieDetailUseCase

extension MovieDetailUseCasePlatform: MovieDetailUseCase {
  public var movieCard: (MovieEntity.MovieDetail.MovieCard.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.MovieCard.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.pathList.movieID)"],
        httpMethod: .get,
        content: .queryItemPath(item.queryItemPath))
        .fetch(isDebug: true)
    }
  }

  public var review: (MovieEntity.MovieDetail.Review.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Review.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.pathList.movieID)", "reviews"],
        httpMethod: .get,
        content: .queryItemPath(item.queryItemPath))
        .fetch(isDebug: true)
    }
  }

  public var credit: (MovieEntity.MovieDetail.Credit.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Credit.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.pathList.movieID)", "credits"],
        httpMethod: .get,
        content: .queryItemPath(item.queryItemPath))
        .fetch(isDebug: true)
    }
  }

  public var similarMovie: (MovieEntity.MovieDetail.SimilarMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.SimilarMovie.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.pathList.movieID)", "similar"],
        httpMethod: .get,
        content: .queryItemPath(item.queryItemPath))
        .fetch(isDebug: true)
    }
  }

  public var recommendedMovie: (MovieEntity.MovieDetail.RecommendedMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.RecommendedMovie.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.pathList.movieID)", "recommendations"],
        httpMethod: .get,
        content: .queryItemPath(item.queryItemPath))
        .fetch(isDebug: true)
    }
  }
}
