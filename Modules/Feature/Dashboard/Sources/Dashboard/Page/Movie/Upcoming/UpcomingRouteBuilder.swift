import Architecture
import LinkNavigator
import Domain

struct UpcomingRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.upcoming.rawValue
    
    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      
      return DebugWrappingController(matchPath: matchPath) {
        UpcomingPage(store: .init(
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
