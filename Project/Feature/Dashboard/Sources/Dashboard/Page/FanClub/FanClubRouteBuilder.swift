import Architecture
import LinkNavigator

struct FanClubRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.fanClub.rawValue
    
    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      
      return DebugWrappingController(matchPath: matchPath) {
        FanClubPage(store: .init(
          initialState: FanClubReducer.State(),
          reducer: {
            FanClubReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
