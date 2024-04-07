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
      SimilarRouteBuilder.generate(),
      RecommendedRouteBuilder.generate(),
      MovieDetailRouteBuilder.generate(),
      ReviewRouteBuilder.generate(),
      CastRouteBuilder.generate(),
      CrewRouteBuilder.generate(),
      OtherPosterRouteBuilder.generate(),
      DiscoverRouteBuilder.generate(),
      FanClubRouteBuilder.generate(),
      ProfileRouteBuilder.generate(),
      MyListRouteBuilder.generate(),
      NewListRouteBuilder.generate(),
    ]
  }
}
