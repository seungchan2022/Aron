import Architecture
import Domain
import LinkNavigator

struct MovieListRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.movieList.rawValue

    return .init(matchPath: matchPath) { navigator, _, diContainer -> RouteViewController? in
      guard let env: MovieEnvironmentUsable = diContainer.resolve() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        MovieListPage(
          store: .init(
            initialState: MovieListReducer.State(),
            reducer: {
              MovieListReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          settingStore: .init(
            initialState: SettingReducer.State(),
            reducer: {
              SettingReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }))
      }
    }
  }
}
