import Combine
import Domain

// MARK: - SearchUseCasePlatform

public struct SearchUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.themoviedb.org/3/search") {
    self.baseURL = baseURL
  }
}

// MARK: SearchUseCase

extension SearchUseCasePlatform: SearchUseCase {
  public var searchMovie: (MovieEntity.Search.Movie.Request) -> AnyPublisher<
    MovieEntity.Search.Movie.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["movie"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var searchKeyword: (MovieEntity.Search.Keyword.Request) -> AnyPublisher<
    MovieEntity.Search.Keyword.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["keyword"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }
  
  public var searchPerson: (MovieEntity.Search.Person.Request) -> AnyPublisher<MovieEntity.Search.Person.Response, CompositeErrorRepository> {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["person"],
        httpMethod: .get,
        content: .queryItemPath($0))
      .fetch(isDebug: true)
    }
  }
}
