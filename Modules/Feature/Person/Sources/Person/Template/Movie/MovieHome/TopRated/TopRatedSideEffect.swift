import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TopRatedSideEffect

public struct TopRatedSideEffect {
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

extension TopRatedSideEffect {
  var getItem: (MovieEntity.Movie.TopRated.Request) -> Effect<TopRatedReducer.Action> {
    { item in
      .publisher {
        useCase.movieUseCase.topRated(item)
          .receive(on: main)
          .mapToResult()
          .map(TopRatedReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.Movie.TopRated.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Movie.TopRated.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}
