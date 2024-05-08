import Combine
import Domain

// MARK: - MovieUseCasePlatform

public struct MovieUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.themoviedb.org/3/movie") {
    self.baseURL = baseURL
  }

}

// MARK: MovieUseCase

extension MovieUseCasePlatform: MovieUseCase {
  public var nowPlaying: (MovieEntity.Movie.NowPlaying.Request) -> AnyPublisher<
    MovieEntity.Movie.NowPlaying.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["now_playing"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var upcoming: (MovieEntity.Movie.Upcoming.Request) -> AnyPublisher<
    MovieEntity.Movie.Upcoming.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["upcoming"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var trending: (MovieEntity.Movie.Trending.Request) -> AnyPublisher<
    MovieEntity.Movie.Trending.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: "https://api.themoviedb.org/3",
        pathList: ["trending", "movie", "day"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var popular: (MovieEntity.Movie.Popular.Request) -> AnyPublisher<
    MovieEntity.Movie.Popular.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["popular"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var topRated: (MovieEntity.Movie.TopRated.Request) -> AnyPublisher<
    MovieEntity.Movie.TopRated.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["top_rated"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var genreList: (MovieEntity.Movie.GenreList.Request) -> AnyPublisher<
    MovieEntity.Movie.GenreList.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: "https://api.themoviedb.org/3",
        pathList: ["genre", "movie", "list"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }
}
