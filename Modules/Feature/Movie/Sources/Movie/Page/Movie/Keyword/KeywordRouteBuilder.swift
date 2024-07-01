import Architecture
import Domain
import LinkNavigator

struct KeywordRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.keyword.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: MovieEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.MovieCard.KeywordItem = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        KeywordPage(store: .init(
          initialState: KeywordReducer.State(item: item),
          reducer: {
            KeywordReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
