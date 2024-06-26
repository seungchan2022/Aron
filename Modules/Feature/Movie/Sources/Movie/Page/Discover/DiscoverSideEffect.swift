import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - DiscoverSideEffect

public struct DiscoverSideEffect {
  public let useCase: MovieEnvironmentUsable
  public let main: AnySchedulerOf<DispatchQueue>
  public let navigator: RootNavigatorType

  public init(
    useCase: MovieEnvironmentUsable,
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
          path: Link.Common.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Discover.Movie.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}
