import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MovieListSideEffect

struct MovieListSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType
  
  
  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
    
  }
}

extension MovieListSideEffect {
  var getNowPlayingItem: (MovieEntity.Movie.NowPlaying.Request) -> Effect<MovieListReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.nowPlaying(item)
            .receive(on: main)
            .mapToResult()
            .map(MovieListReducer.Action.fetchNowPlayingItem)
        }
    }
  }
  
  var getUpcomingItem: (MovieEntity.Movie.Upcoming.Request) -> Effect<MovieListReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.upcoming(item)
            .receive(on: main)
            .mapToResult()
            .map(MovieListReducer.Action.fetchUpcomingItem)
        }
    }
  }
  
  var getTrendingItem: (MovieEntity.Movie.Trending.Request) -> Effect<MovieListReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.trending(item)
            .receive(on: main)
            .mapToResult()
            .map(MovieListReducer.Action.fetchTrendingItem)
        }
    }
  }
  
  var getPopularItem: (MovieEntity.Movie.Popular.Request) -> Effect<MovieListReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.popular(item)
            .receive(on: main)
            .mapToResult()
            .map(MovieListReducer.Action.fetchPopularItem)
        }
    }
  }
  
  var getTopRatedItem: (MovieEntity.Movie.TopRated.Request) -> Effect<MovieListReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.topRated(item)
            .receive(on: main)
            .mapToResult()
            .map(MovieListReducer.Action.fetchTopRatedItem)
        }
    }
  }
  
  var getGenreItem: (MovieEntity.Movie.GenreList.Request) -> Effect<MovieListReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.genreList(item)
            .receive(on: main)
            .mapToResult()
            .map(MovieListReducer.Action.fetchGenreItem)
        }
    }
  }
  
  var routeToMovieHome: () -> Void {
    {
      navigator.back(isAnimated: false)
    }
  }
  
  var routeToNowPlayingDetail: (MovieEntity.Movie.NowPlaying.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
  
  var routeToUpcomingDetail: (MovieEntity.Movie.Upcoming.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
  
  var routeToTrendingDetail: (MovieEntity.Movie.Trending.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
  
  var routeToPopularDetail: (MovieEntity.Movie.Popular.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
  
  var routeToTopRatedDetail: (MovieEntity.Movie.TopRated.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
  
  var routeToGenreDetail: (MovieEntity.Movie.GenreList.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.genre.rawValue,
          items: item),
        isAnimated: true)
    }
  }
  
  var routeToNowPlaying: () -> Void {
    {
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.nowPlaying.rawValue,
          items: NowPlayingRouteItem.init(isNavigationBarLargeTitle: true)),
        isAnimated: true)
    }
  }
  
  var routeToUpcoming: () -> Void {
    {
      navigator.next(
        linkItem: .init(path: Link.Dashboard.Path.upcoming.rawValue),
        isAnimated: true)
    }
  }
  
  var routeToTrending: () -> Void {
    {
      navigator.next(
        linkItem: .init(path: Link.Dashboard.Path.trending.rawValue),
        isAnimated: true)
    }
  }
  
  var routeToPopular: () -> Void {
    {
      navigator.next(
        linkItem: .init(path: Link.Dashboard.Path.popular.rawValue),
        isAnimated: true)
    }
  }
  
  var routeToTopRated: () -> Void {
    {
      navigator.next(
        linkItem: .init(path: Link.Dashboard.Path.topRated.rawValue),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Movie.NowPlaying.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Movie.Upcoming.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Movie.Trending.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Movie.Popular.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Movie.TopRated.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Movie.GenreList.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.Genre.Request {
    .init(genreID: id)
  }
}

