import Architecture
import Domain
import LinkNavigator

struct HomeRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.home.rawValue

    return .init(matchPath: matchPath) { navigator, _, diContainer -> RouteViewController? in
      guard let env: MovieEnvironmentUsable = diContainer.resolve() else { return .none }

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
            }),
          trendingStore: .init(
            initialState: TrendingReducer.State(),
            reducer: {
              TrendingReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          popularStore: .init(
            initialState: PopularReducer.State(),
            reducer: {
              PopularReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          topRatedStore: .init(
            initialState: TopRatedReducer.State(),
            reducer: {
              TopRatedReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          genreListStore: .init(
            initialState: GenreListReducer.State(),
            reducer: {
              GenreListReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }),
          settingStore: .init(
            initialState: SettingReducer.State(),
            reducer: {
              SettingReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
            }))
      }
    }
  }
}
