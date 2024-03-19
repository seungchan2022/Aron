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
}
