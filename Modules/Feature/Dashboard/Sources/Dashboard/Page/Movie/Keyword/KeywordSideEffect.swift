import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - KeywordSideEffect

struct KeywordSideEffect {
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

extension KeywordSideEffect {
  var getItem: (MovieEntity.MovieDetail.Keyword.Request) -> Effect<KeywordReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.keyword(request)
          .receive(on: main)
          .mapToResult()
          .map(KeywordReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.MovieDetail.Keyword.Response.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.Keyword.Response.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}
