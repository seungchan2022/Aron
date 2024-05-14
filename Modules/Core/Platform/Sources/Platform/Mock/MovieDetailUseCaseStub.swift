import Combine
import Domain
import Foundation

// MARK: - MovieDetailUseCaseStub

public final class MovieDetailUseCaseStub {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public var type: ResponseType = .success
  public var response: Response = .init()
}

// MARK: MovieDetailUseCase

extension MovieDetailUseCaseStub: MovieDetailUseCase {
  public var movieCard: (MovieEntity.MovieDetail.MovieCard.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.MovieCard.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().movieCard.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var review: (MovieEntity.MovieDetail.Review.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Review.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().review.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var credit: (MovieEntity.MovieDetail.Credit.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Credit.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().credit.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var similarMovie: (MovieEntity.MovieDetail.SimilarMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.SimilarMovie.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().similarMovie.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var recommendedMovie: (MovieEntity.MovieDetail.RecommendedMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.RecommendedMovie.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().recommendedMovie.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

}

extension MovieDetailUseCaseStub {
  public enum ResponseType: Equatable, Sendable {
    case success
    case failure(CompositeErrorRepository)
  }

  public struct Response: Equatable, Sendable {

    // MARK: Lifecycle

    public init() { }

    // MARK: Public

    public var movieCard = DataResponseMock<MovieEntity.MovieDetail.MovieCard.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieDetailMovieCardSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieDetailMovieCardFailureJson.url)!))

    public var review = DataResponseMock<MovieEntity.MovieDetail.Review.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieDetailReviewSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieDetailReviewFailureJson.url)!))

    public var credit = DataResponseMock<MovieEntity.MovieDetail.Credit.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieDetailCreditSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieDetailCreditFailureJson.url)!))

    public var similarMovie = DataResponseMock<MovieEntity.MovieDetail.SimilarMovie.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieDetailSimilarSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieDetailSimilarFailureJson.url)!))

    public var recommendedMovie = DataResponseMock<MovieEntity.MovieDetail.RecommendedMovie.Response>(
      successValue: URLSerializedMockFunctor
        .serialized(url: Files.movieDetailRecommendedSuccessJson.url)!,
      failureValue: CompositeErrorRepository
        .remoteError(
          URLSerializedMockFunctor
            .serialized(url: Files.movieDetailRecommendedFailureJson.url)!))
  }
}
