import Combine

public protocol MovieDiscoverUseCase {
  var movie: (MovieEntity.Discover.Movie.Request)
    -> AnyPublisher<MovieEntity.Discover.Movie.Response, CompositeErrorRepository> { get }

  var genre: (MovieEntity.Discover.Genre.Request)
    -> AnyPublisher<MovieEntity.Discover.Genre.Response, CompositeErrorRepository> { get }

  var keyword: (MovieEntity.Discover.Keyword.Request) -> AnyPublisher<
    MovieEntity.Discover.Keyword.Response,
    CompositeErrorRepository
  > { get }
}
