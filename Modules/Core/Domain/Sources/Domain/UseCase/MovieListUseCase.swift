import Combine

public protocol MovieListUseCase {
  var getIsWishLike: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> { get }
  var getIsSeenLike: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> { get }

  var saveWishList: (MovieEntity.MovieDetail.MovieCard.Response)
    -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> { get }

  var saveSeenList: (MovieEntity.MovieDetail.MovieCard.Response)
    -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> { get }
}
