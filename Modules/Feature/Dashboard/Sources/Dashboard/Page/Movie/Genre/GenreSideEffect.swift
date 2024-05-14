import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - GenreSideEffect

struct GenreSideEffect {
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

extension GenreSideEffect {
  var getItem: (MovieEntity.MovieDetail.MovieCard.GenreItem) -> Effect<GenreReducer.Action> {
    { item in
      .publisher {
        useCase.movieDiscoverUseCase.genre(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(GenreReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.Discover.Genre.Response.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.MovieCard.GenreItem {
  fileprivate func serialized() -> MovieEntity.Discover.Genre.Request {
    .init(genreID: id)
  }
}

extension MovieEntity.Discover.Genre.Response.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}
