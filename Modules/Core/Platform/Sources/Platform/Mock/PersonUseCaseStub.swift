import Combine
import Domain
import Foundation

// MARK: - PersonUseCaseStub

public final class PersonUseCaseStub {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public var type: ResponseType = .success
  public var response: Response = .init()
}

// MARK: PersonUseCase

extension PersonUseCaseStub: PersonUseCase {
  public var info: (MovieEntity.Person.Info.Request) -> AnyPublisher<MovieEntity.Person.Info.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().info.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var image: (MovieEntity.Person.Image.Request) -> AnyPublisher<
    MovieEntity.Person.Image.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().image.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var movieCredit: (MovieEntity.Person.MovieCredit.Request) -> AnyPublisher<
    MovieEntity.Person.MovieCredit.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().movieCredit.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
}

extension PersonUseCaseStub {
  public enum ResponseType: Equatable, Sendable {
    case success
    case failure(CompositeErrorRepository)
  }

  public struct Response: Equatable, Sendable {

    // MARK: Lifecycle

    public init() { }

    // MARK: Public

    public var info = DataResponseMock<MovieEntity.Person.Info.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.personInfoSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.personInfoFailureJson.url)!))

    public var image = DataResponseMock<MovieEntity.Person.Image.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.personImageSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.personImageFailureJson.url)!))

    public var movieCredit = DataResponseMock<MovieEntity.Person.MovieCredit.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.personMovieCreditSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.personMovieCreditFailureJson.url)!))
  }
}
