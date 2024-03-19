import Architecture
import Domain
import LinkNavigator

struct MovieDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.movieDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.MovieCard.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        MovieDetailPage(store: .init(
          initialState: MovieDetailReducer.State(item: item),
          reducer: {
            MovieDetailReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
