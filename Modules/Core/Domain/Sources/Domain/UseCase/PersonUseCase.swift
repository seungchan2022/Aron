import Combine

public protocol PersonUseCase {
  var person: (MovieEntity.Person.Request) -> AnyPublisher<MovieEntity.Person.Response, CompositeErrorRepository> { get }
}
