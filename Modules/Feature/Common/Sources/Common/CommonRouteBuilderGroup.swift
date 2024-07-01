import Architecture
import LinkNavigator

// MARK: - CommonRouteBuilderGroup

public struct CommonRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension CommonRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      MovieDetailRouteBuilder.generate(),
      ReviewRouteBuilder.generate(),
      OtherPosterRouteBuilder.generate(),
      ProfileRouteBuilder.generate(),
    ]
  }
}
