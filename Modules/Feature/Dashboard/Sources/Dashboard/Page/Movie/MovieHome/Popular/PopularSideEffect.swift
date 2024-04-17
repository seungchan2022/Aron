import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - PopularSideEffect

struct PopularSideEffect {
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

extension PopularSideEffect {
  var getItem: (MovieEntity.Movie.Popular.Request) -> Effect<PopularReducer.Action> {
    { item in
      .publisher {
        useCase.movieUseCase.popular(item)
          .receive(on: main)
          .mapToResult()
          .map(PopularReducer.Action.fetchItem)
      }
    }
  }
  
  var searchMovieItem: (MovieEntity.Search.Movie.Request) -> Effect<PopularReducer.Action> {
    { item in
      .publisher {
        useCase.searchUseCase.searchMovie(item)
          .receive(on: main)
          .map {
            MovieEntity.Search.Movie.Composite(
              request: item,
              response: $0)
          }
          .mapToResult()
          .map(PopularReducer.Action.fetchSearchMovieItem)
      }
    }
  }

  var searchKeywordItem: (MovieEntity.Search.Keyword.Request) -> Effect<PopularReducer.Action> {
    { item in
      .publisher {
        useCase.searchUseCase.searchKeyword(item)
          .receive(on: main)
          .map {
            MovieEntity.Search.Keyword.Composite(
              request: item,
              response: $0)
          }
          .mapToResult()
          .map(PopularReducer.Action.fetchSearchKeywordItem)
      }
    }
  }
  
  var searchPersonItem: (MovieEntity.Search.Person.Request) -> Effect<PopularReducer.Action> {
    { item in
        .publisher {
          useCase.searchUseCase.searchPerson(item)
            .receive(on: main)
            .map {
              MovieEntity.Search.Person.Composite(
                request: item,
                response: $0)
            }
            .mapToResult()
            .map(PopularReducer.Action.fetchSearchPersonItem)
        }
    }
  }


  var routeToDetail: (MovieEntity.Movie.Popular.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
  
  var routeToSearchMovieDetail: (MovieEntity.Search.Movie.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
  
  var routeToSearchKeyword: (MovieEntity.Search.Keyword.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.keyword.rawValue,
          items: item),
        isAnimated: true)
    }
  }
  
  var routeToSearchPerson: (MovieEntity.Search.Person.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.profile.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Movie.Popular.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Search.Movie.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Search.Person.Item {
  fileprivate func serialized() -> MovieEntity.Person.Info.Request {
    .init(personID: id)
  }
}
