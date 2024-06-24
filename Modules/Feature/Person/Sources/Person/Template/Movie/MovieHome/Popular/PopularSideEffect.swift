import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - PopularSideEffect

public struct PopularSideEffect {
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

  var routeToDetail: (MovieEntity.Movie.Popular.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
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
