import Architecture
import Foundation
import LinkNavigator

// MARK: - PopularRouteBuilder

struct PopularRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.popular.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: MovieEnvironmentUsable = diContainer.resolve() else { return .none }

      let query: PopularRouteItem = items.decoded() ?? .init()

      return DebugWrappingController(matchPath: matchPath) {
        PopularPage(
          store: .init(
            initialState: PopularReducer.State(),
            reducer: {
              PopularReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          isNavigationBarLargeTitle: query.isNavigationBarLargeTitle)
      }
    }
  }
}

// MARK: - PopularRouteItem

struct PopularRouteItem: Equatable, Codable, Sendable {
  let isNavigationBarLargeTitle: Bool

  init(isNavigationBarLargeTitle: Bool = true) {
    self.isNavigationBarLargeTitle = isNavigationBarLargeTitle
  }
}
