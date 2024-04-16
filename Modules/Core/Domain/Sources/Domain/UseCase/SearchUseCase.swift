import Combine

public protocol SearchUseCase {
  var searchMovie: (MovieEntity.Search.Movie.Request) -> AnyPublisher<MovieEntity.Search.Movie.Response, CompositeErrorRepository> { get }
}

