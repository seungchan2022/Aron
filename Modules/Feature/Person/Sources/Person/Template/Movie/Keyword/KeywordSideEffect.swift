import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - KeywordSideEffect

public struct KeywordSideEffect {
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

extension KeywordSideEffect {

  var getItem: (MovieEntity.MovieDetail.MovieCard.KeywordItem) -> Effect<KeywordReducer.Action> {
    { item in
      .publisher {
        useCase.movieDiscoverUseCase.keyword(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(KeywordReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.Discover.Keyword.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.MovieCard.KeywordItem {
  fileprivate func serialized() -> MovieEntity.Discover.Keyword.Request {
    .init(keywordID: id)
  }
}

extension MovieEntity.Discover.Keyword.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}
