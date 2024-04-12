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
