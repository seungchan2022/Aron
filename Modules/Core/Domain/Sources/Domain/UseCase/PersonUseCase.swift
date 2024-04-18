import Combine

public protocol PersonUseCase {
  var info: (MovieEntity.Person.Info.Request) -> AnyPublisher<MovieEntity.Person.Info.Response, CompositeErrorRepository> { get }
  var image: (MovieEntity.Person.Image.Request)
    -> AnyPublisher<MovieEntity.Person.Image.Response, CompositeErrorRepository> { get }
  
  var movieCredit: (MovieEntity.Person.MovieCredit.Request) -> AnyPublisher<MovieEntity.Person.MovieCredit.Response, CompositeErrorRepository> { get }
}
