import Architecture
import LinkNavigator

// MARK: - NowPlayingRouteBuilder

struct NowPlayingRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.nowPlaying.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: MovieEnvironmentUsable = diContainer.resolve() else { return .none }

      let query: NowPlayingRouteItem = items.decoded() ?? .init()

      return DebugWrappingController(matchPath: matchPath) {
        NowPlayingPage(
          store: .init(
            initialState: NowPlayingReducer.State(),
            reducer: {
              NowPlayingReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          isNavigationBarLargeTitle: query.isNavigationBarLargeTitle)
      }
    }
  }
}

// MARK: - NowPlayingRouteItem

struct NowPlayingRouteItem: Equatable, Codable, Sendable {
  let isNavigationBarLargeTitle: Bool

  init(isNavigationBarLargeTitle: Bool = true) {
    self.isNavigationBarLargeTitle = isNavigationBarLargeTitle
  }
}
