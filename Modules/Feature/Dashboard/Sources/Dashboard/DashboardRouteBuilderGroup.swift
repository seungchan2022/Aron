import Architecture
import LinkNavigator

// MARK: - DashboardRouteBuilderGroup

public struct DashboardRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension DashboardRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      NowPlayingRouteBuilder.generate(),
      MovieDetailRouteBuilder.generate(),
      ReviewRouteBuilder.generate(),
      DiscoverRouteBuilder.generate(),
      FanClubRouteBuilder.generate(),
      MyListRouteBuilder.generate(),
      NewListRouteBuilder.generate(),
    ]
  }
}
