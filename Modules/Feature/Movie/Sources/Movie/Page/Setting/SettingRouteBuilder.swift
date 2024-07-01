import Architecture
import LinkNavigator

struct SettingRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.setting.rawValue

    return .init(matchPath: matchPath) { navigator, _, diContainer -> RouteViewController? in
      guard let env: MovieEnvironmentUsable = diContainer.resolve() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        SettingPage(
          store: .init(
            initialState: SettingReducer.State(),
            reducer: {
              SettingReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }), scheme: .light)
      }
    }
  }
}
