import Architecture
import Domain
import LinkNavigator

struct RecommendedRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.recommended.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: MovieEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.RecommendedMovie.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        RecommendedPage(store: .init(
          initialState: RecommendedReducer.State(item: item),
          reducer: {
            RecommendedReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
