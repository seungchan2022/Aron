import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - RecommendedSideEffect

struct RecommendedSideEffect {
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

extension RecommendedSideEffect {
  var recommended: (MovieEntity.MovieDetail.RecommendedMovie.Request) -> Effect<RecommendedReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.recommendedMovie(request)
          .receive(on: main)
          .mapToResult()
          .map(RecommendedReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.MovieDetail.RecommendedMovie.Response.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.RecommendedMovie.Response.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.RecommendedMovie.Request {
    .init(movieID: id)
  }
}