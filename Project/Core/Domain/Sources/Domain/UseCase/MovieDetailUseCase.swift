import Combine

public protocol MovieDetailUseCase {
  var movieCard: (MovieEntity.MovieDetail.MovieCard.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.MovieCard.Response,
    CompositeErrorRepository
  > { get }

  var review: (MovieEntity.MovieDetail.Review.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Review.Response,
    CompositeErrorRepository
  > { get }

  var credit: (MovieEntity.MovieDetail.Credit.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Credit.Response,
    CompositeErrorRepository
  > { get }
}
