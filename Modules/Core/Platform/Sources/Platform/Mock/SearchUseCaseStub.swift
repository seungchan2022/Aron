import Combine
import Domain
import Foundation

public final class SearchUseCaseStub {
 
  public init() { }
  
  public var type: ResponseType = .success
  public var response: Response = .init()
  
}

extension SearchUseCaseStub: SearchUseCase {
  public var searchMovie: (MovieEntity.Search.Movie.Request) -> AnyPublisher<MovieEntity.Search.Movie.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().searchMovie.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
      
    }
  }
   
  public var searchKeyword: (MovieEntity.Search.Keyword.Request) -> AnyPublisher<MovieEntity.Search.Keyword.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().searchKeyword.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
      
    }
  }
  
  public var searchPerson: (MovieEntity.Search.Person.Request) -> AnyPublisher<MovieEntity.Search.Person.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().searchPerson.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
      
    }
  }
}


extension SearchUseCaseStub {
  public enum ResponseType: Equatable, Sendable {
    case success
    case failure(CompositeErrorRepository)
  }
  
  public struct Response: Equatable, Sendable {
    
    public init() { }
    
    public var searchMovie = DataResponseMock<MovieEntity.Search.Movie.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.searchMovieSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.searchMovieFailureJson.url)!))
    
    public var searchKeyword = DataResponseMock<MovieEntity.Search.Keyword.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.searchKeywordSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.searchKeywordFailureJson.url)!))
    
    public var searchPerson = DataResponseMock<MovieEntity.Search.Person.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.searchPersonSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.searchPersonFailureJson.url)!))
    
  }
}
