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
}
