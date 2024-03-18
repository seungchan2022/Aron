import Architecture
import LinkNavigator

struct DiscoverRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.discover.rawValue
    
    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      
      return DebugWrappingController(matchPath: matchPath) {
        DiscoverPage(store: .init(
          initialState: DiscoverReducer.State(),
          reducer: {
            DiscoverReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
