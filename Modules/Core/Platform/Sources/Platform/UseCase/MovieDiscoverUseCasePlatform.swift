import Combine
import Domain

// MARK: - MovieDiscoverUseCasePlatform

public struct MovieDiscoverUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.themoviedb.org/3/discover/movie") {
    self.baseURL = baseURL
  }
}

// MARK: MovieDiscoverUseCase

extension MovieDiscoverUseCasePlatform: MovieDiscoverUseCase {
  public var movie: (MovieEntity.Discover.Movie.Request) -> AnyPublisher<
    MovieEntity.Discover.Movie.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: [],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var genre: (MovieEntity.Discover.Genre.Request) -> AnyPublisher<
    MovieEntity.Discover.Genre.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: [],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var keyword: (MovieEntity.Discover.Keyword.Request) -> AnyPublisher<
    MovieEntity.Discover.Keyword.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: [],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }
}
