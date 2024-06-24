import Architecture
import Domain
import LinkNavigator

struct GenreRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.genre.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: MyEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.MovieCard.GenreItem = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        GenrePage(store: .init(
          initialState: GenreReducer.State(item: item),
          reducer: {
            GenreReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
