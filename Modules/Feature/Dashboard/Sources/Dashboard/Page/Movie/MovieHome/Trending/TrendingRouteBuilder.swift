import Architecture
import Domain
import LinkNavigator

struct TrendingRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.trending.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }

      let query: TrendingRouteItem = items.decoded() ?? .init()

      return DebugWrappingController(matchPath: matchPath) {
        TrendingPage(store: .init(
          initialState: TrendingReducer.State(),
          reducer: {
            TrendingReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }), 
                     isNavigationBarLargeTitle: query.isNavigationBarLargeTitle)
      }
    }
  }
}

struct  TrendingRouteItem: Equatable, Codable, Sendable {
  let isNavigationBarLargeTitle: Bool
  
  init(isNavigationBarLargeTitle: Bool = true) {
    self.isNavigationBarLargeTitle = isNavigationBarLargeTitle
  }
}
