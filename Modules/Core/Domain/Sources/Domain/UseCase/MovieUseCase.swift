import Combine

public protocol MovieUseCase {
  var nowPlaying: (MovieEntity.Movie.NowPlaying.Request) -> AnyPublisher<
    MovieEntity.Movie.NowPlaying.Response,
    CompositeErrorRepository
  > { get }

  var upcoming: (MovieEntity.Movie.Upcoming.Request) -> AnyPublisher<
    MovieEntity.Movie.Upcoming.Response,
    CompositeErrorRepository
  > { get }

  var trending: (MovieEntity.Movie.Trending.Request) -> AnyPublisher<
    MovieEntity.Movie.Trending.Response,
    CompositeErrorRepository
  > { get }

  var popular: (MovieEntity.Movie.Popular.Request)
    -> AnyPublisher<MovieEntity.Movie.Popular.Response,CompositeErrorRepository> { get }

  var topRated: (MovieEntity.Movie.TopRated.Request) -> AnyPublisher<
    MovieEntity.Movie.TopRated.Response,
    CompositeErrorRepository
  > { get }
  
  var genreList: (MovieEntity.Movie.GenreList.Request) -> AnyPublisher<MovieEntity.Movie.GenreList.Response, CompositeErrorRepository> { get }
}
