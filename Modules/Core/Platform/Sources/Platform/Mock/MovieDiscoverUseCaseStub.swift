import Combine
import Domain
import Foundation

// MARK: - MovieDiscoverUseCaseStub

public final class MovieDiscoverUseCaseStub {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public var type: ResponseType = .success
  public var response: Response = .init()
}

// MARK: MovieDiscoverUseCase

extension MovieDiscoverUseCaseStub: MovieDiscoverUseCase {
  public var genre: (MovieEntity.Discover.Genre.Request) -> AnyPublisher<
    MovieEntity.Discover.Genre.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().genre.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var keyword: (MovieEntity.Discover.Keyword.Request) -> AnyPublisher<
    MovieEntity.Discover.Keyword.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().keyword.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
}

extension MovieDiscoverUseCaseStub {
  public enum ResponseType: Equatable, Sendable {
    case success
    case failure(CompositeErrorRepository)
  }

  public struct Response: Equatable, Sendable {
    public init() { }

    public var genre = DataResponseMock<MovieEntity.Discover.Genre.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieDiscoverGenreSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieDiscoverGenreFailureJson.url)!))

    public var keyword = DataResponseMock<MovieEntity.Discover.Keyword.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieDiscoverKeywordSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieDiscoverKeywordFailureJson.url)!))
  }
}
