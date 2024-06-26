import Combine

public protocol SearchUseCase {
  var searchMovie: (MovieEntity.Search.Movie.Request) -> AnyPublisher<
    MovieEntity.Search.Movie.Response,
    CompositeErrorRepository
  > { get }

  var searchKeyword: (MovieEntity.Search.Keyword.Request) -> AnyPublisher<
    MovieEntity.Search.Keyword.Response,
    CompositeErrorRepository
  > { get }

  var searchPerson: (MovieEntity.Search.Person.Request) -> AnyPublisher<
    MovieEntity.Search.Person.Response,
    CompositeErrorRepository
  > { get }
}
