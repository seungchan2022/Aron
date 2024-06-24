import Architecture
import LinkNavigator

// MARK: - MyRouteBuilderGroup

public struct MyRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension MyRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      MyListRouteBuilder.generate(),
    ]
  }

  public static var template: [RouteBuilderOf<RootNavigator>] {
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
      SettingRouteBuilder.generate(),
      CastRouteBuilder.generate(),
      CrewRouteBuilder.generate(),
      FanClubRouteBuilder.generate(),
      ProfileRouteBuilder.generate(),
    ]
  }
}
