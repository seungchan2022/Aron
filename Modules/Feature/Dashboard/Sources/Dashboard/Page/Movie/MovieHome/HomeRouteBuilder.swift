import Architecture
import Domain
import LinkNavigator

struct HomeRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.home.rawValue

    return .init(matchPath: matchPath) { navigator, _, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        HomePage(
          store: .init(
            initialState: HomeReducer.State(),
            reducer: {
              HomeReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          nowPlayingStore: .init(
            initialState: NowPlayingReducer.State(),
            reducer: {
              NowPlayingReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          upcomingStore: .init(
            initialState: UpcomingReducer.State(),
            reducer: {
              UpcomingReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }))
      }
    }
  }
}