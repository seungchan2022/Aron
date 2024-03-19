import Combine

public protocol MovieDetailUseCase {
  var movieCard: (MovieEntity.MovieDetail.MovieCard.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.MovieCard.Response,
    CompositeErrorRepository
  > { get }
}
