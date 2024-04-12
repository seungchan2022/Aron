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

  var similarMovie: (MovieEntity.MovieDetail.SimilarMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.SimilarMovie.Response,
    CompositeErrorRepository
  > { get }

  var recommendedMovie: (MovieEntity.MovieDetail.RecommendedMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.RecommendedMovie.Response,
    CompositeErrorRepository
  > { get }

  var genre: (MovieEntity.MovieDetail.Genre.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Genre.Response,
    CompositeErrorRepository
  > { get }
}
