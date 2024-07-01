import Architecture
import LinkNavigator

// MARK: - MovieRouteBuilderGroup

public struct MovieRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension MovieRouteBuilderGroup {
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
      DiscoverRouteBuilder.generate(),
      SettingRouteBuilder.generate(),
    ]
  }
}
