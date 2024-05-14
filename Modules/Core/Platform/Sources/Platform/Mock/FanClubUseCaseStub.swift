import Combine
import Domain
import Foundation

// MARK: - FanClubUseCaseStub

public final class FanClubUseCaseStub {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public var type: ResponseType = .success
  public var response: Response = .init()
}

// MARK: FanClubUseCase

extension FanClubUseCaseStub: FanClubUseCase {
  public var fanClub: (MovieEntity.FanClub.Request) -> AnyPublisher<MovieEntity.FanClub.Response, CompositeErrorRepository> {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().fanClub.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
}

extension FanClubUseCaseStub {
  public enum ResponseType: Equatable, Sendable {
    case success
    case failure(CompositeErrorRepository)
  }

  public struct Response: Equatable, Sendable {

    public init() { }

    public var fanClub = DataResponseMock<MovieEntity.FanClub.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.fanClubSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.fanClubFailureJson.url)!))
  }
}
