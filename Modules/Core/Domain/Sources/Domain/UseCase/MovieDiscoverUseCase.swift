import Combine

public protocol MovieDiscoverUseCase {
  var genre: (MovieEntity.Discover.Genre.Request)
    -> AnyPublisher<MovieEntity.Discover.Genre.Response, CompositeErrorRepository> { get }

  var keyword: (MovieEntity.Discover.Keyword.Request) -> AnyPublisher<
    MovieEntity.Discover.Keyword.Response,
    CompositeErrorRepository
  > { get }
}
