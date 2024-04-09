import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TrendingSideEffect

struct TrendingSideEffect {
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

extension TrendingSideEffect {
  var getItem: (MovieEntity.Movie.Trending.Request) -> Effect<TrendingReducer.Action> {
    { item in
      .publisher {
        useCase.movieUseCase.trending(item)
          .receive(on: main)
          .mapToResult()
          .map(TrendingReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.Movie.Trending.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Movie.Trending.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}