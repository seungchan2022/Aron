import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - DiscoverSideEffect

struct DiscoverSideEffect {
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

extension DiscoverSideEffect {
  var getItem: (MovieEntity.Discover.Movie.Request) -> Effect<DiscoverReducer.Action> {
    { item in
      .publisher {
        useCase.movieDiscoverUseCase.movie(item)
          .receive(on: main)
          .mapToResult()
          .map(DiscoverReducer.Action.fetchItem)
      }
    }
  }
  
  var routeToDetail: (MovieEntity.Discover.Movie.Item) -> Void {
    { item in
      navigator.sheet(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Discover.Movie.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: self.id)
  }
}
