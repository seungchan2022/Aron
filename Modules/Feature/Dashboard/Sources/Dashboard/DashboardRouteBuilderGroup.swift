import Architecture
import LinkNavigator

// MARK: - DashboardRouteBuilderGroup

public struct DashboardRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension DashboardRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      HomeRouteBuilder.generate(),
      MovieListRouteBuilder.generate(),
      NowPlayingRouteBuilder.generate(),
      UpcomingRouteBuilder.generate(),
      TrendingRouteBuilder.generate(),
      PopularRouteBuilder.generate(),
      TopRatedRouteBuilder.generate(),
      GenreListRouteBuilder.generate(),
      GenreRouteBuilder.generate(),
      KeywordRouteBuilder.generate(),
      SimilarRouteBuilder.generate(),
      RecommendedRouteBuilder.generate(),
      MovieDetailRouteBuilder.generate(),
      ReviewRouteBuilder.generate(),
      OtherPosterRouteBuilder.generate(),
      DiscoverRouteBuilder.generate(),
      MyListRouteBuilder.generate(),
      SettingRouteBuilder.generate(),
    ]
  }

  public static var template: [RouteBuilderOf<RootNavigator>] {
    [
      CastRouteBuilder.generate(),
      CrewRouteBuilder.generate(),
      FanClubRouteBuilder.generate(),
      ProfileRouteBuilder.generate(),
    ]
  }
}
