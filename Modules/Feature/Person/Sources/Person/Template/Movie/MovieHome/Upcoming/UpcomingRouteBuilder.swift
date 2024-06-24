import Architecture
import Domain
import LinkNavigator

// MARK: - UpcomingRouteBuilder

struct UpcomingRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.upcoming.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: PersonEnvironmentUsable = diContainer.resolve() else { return .none }

      let query: UpcomingRouteItem = items.decoded() ?? .init()

      return DebugWrappingController(matchPath: matchPath) {
        UpcomingPage(
          store: .init(
            initialState: UpcomingReducer.State(),
            reducer: {
              UpcomingReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          isNavigationBarLargeTitle: query.isNavigationBarLargeTitle)
      }
    }
  }
}

// MARK: - UpcomingRouteItem

struct UpcomingRouteItem: Equatable, Codable, Sendable {
  let isNavigationBarLargeTitle: Bool

  init(isNavigationBarLargeTitle: Bool = true) {
    self.isNavigationBarLargeTitle = isNavigationBarLargeTitle
  }
}
