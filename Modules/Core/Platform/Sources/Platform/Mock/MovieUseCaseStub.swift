import Combine
import Domain
import Foundation

public final class MovieUseCaseStub {
  
  public init() { }
  
  public var type: ResponseType = .success
  public var response: Response = .init()
}

extension MovieUseCaseStub: MovieUseCase {
  public var nowPlaying: (MovieEntity.Movie.NowPlaying.Request) -> AnyPublisher<MovieEntity.Movie.NowPlaying.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().nowPlaying.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
      
    }
  }
  
  public var upcoming: (MovieEntity.Movie.Upcoming.Request) -> AnyPublisher<MovieEntity.Movie.Upcoming.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().upcoming.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
  
  public var trending: (MovieEntity.Movie.Trending.Request) -> AnyPublisher<MovieEntity.Movie.Trending.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().trending.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
  
  public var popular: (MovieEntity.Movie.Popular.Request) -> AnyPublisher<MovieEntity.Movie.Popular.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().popular.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
  
  public var topRated: (MovieEntity.Movie.TopRated.Request) -> AnyPublisher<MovieEntity.Movie.TopRated.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().topRated.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
  
  public var genreList: (MovieEntity.Movie.GenreList.Request) -> AnyPublisher<MovieEntity.Movie.GenreList.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }
      
      switch type {
      case .success:
        return Just(Response().genreList.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()
        
      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
  
  
}

extension MovieUseCaseStub {
  public enum ResponseType: Equatable, Sendable {
    case success
    case failure(CompositeErrorRepository)
  }
  
  public struct Response: Equatable, Sendable {
    
    public init() { }

    public var nowPlaying = DataResponseMock<MovieEntity.Movie.NowPlaying.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieNowPlayingSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieNowPlayingFailureJson.url)!
        ))
    
    public var upcoming = DataResponseMock<MovieEntity.Movie.Upcoming.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieUpcomingSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieUpcomingFailureJson.url)!))
    
    public var trending = DataResponseMock<MovieEntity.Movie.Trending.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieTrendingSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieTrendingFailureJson.url)!))
    
    public var popular = DataResponseMock<MovieEntity.Movie.Popular.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.moviePopularSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.moviePopularFailureJson.url)!))
    
    public var topRated = DataResponseMock<MovieEntity.Movie.TopRated.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieTopRatedSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieTopRatedFailureJson.url)!))

    public var genreList = DataResponseMock<MovieEntity.Movie.GenreList.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieGenreListSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieGenreListFailureJson.url)!))
  }
}
