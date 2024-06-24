import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - HomeSideEffect

public struct HomeSideEffect {
  public let useCase: PersonEnvironmentUsable
  public let main: AnySchedulerOf<DispatchQueue>
  public let navigator: RootNavigatorType

  public init(
    useCase: PersonEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension HomeSideEffect {

  var searchMovieItem: (MovieEntity.Search.Movie.Request) -> Effect<HomeReducer.Action> {
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
          .map(HomeReducer.Action.fetchSearchMovieItem)
      }
    }
  }

  var searchKeywordItem: (MovieEntity.Search.Keyword.Request) -> Effect<HomeReducer.Action> {
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
          .map(HomeReducer.Action.fetchSearchKeywordItem)
      }
    }
  }

  var searchPersonItem: (MovieEntity.Search.Person.Request) -> Effect<HomeReducer.Action> {
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
          .map(HomeReducer.Action.fetchSearchPersonItem)
      }
    }
  }

  var routeToMovieList: () -> Void {
    {
      navigator.next(
        linkItem: .init(path: Link.Dashboard.Path.movieList.rawValue),
        isAnimated: false)
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
          path: Link.Person.Path.profile.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
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
