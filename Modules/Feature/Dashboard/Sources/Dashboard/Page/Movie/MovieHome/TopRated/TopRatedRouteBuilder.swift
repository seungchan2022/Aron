import Architecture
import Domain
import LinkNavigator

struct TopRatedRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.topRated.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }

      let query: TopRatedRouteItem = items.decoded() ?? .init()

      return DebugWrappingController(matchPath: matchPath) {
        TopRatedPage(store: .init(
          initialState: TopRatedReducer.State(),
          reducer: {
            TopRatedReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }), 
                     isNavigationBarLargeTitle: query.isNavigationBarLargeTitle)
      }
    }
  }
}

struct  TopRatedRouteItem: Equatable, Codable, Sendable {
  let isNavigationBarLargeTitle: Bool
  
  init(isNavigationBarLargeTitle: Bool = true) {
    self.isNavigationBarLargeTitle = isNavigationBarLargeTitle
  }
}
