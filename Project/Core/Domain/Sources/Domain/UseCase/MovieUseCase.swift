import Combine

public protocol MovieUseCase {
  var nowPlaying: (MovieEntity.Movie.NowPlaying.Request) -> AnyPublisher<
    MovieEntity.Movie.NowPlaying.Response,
    CompositeErrorRepository
  > { get }
}
