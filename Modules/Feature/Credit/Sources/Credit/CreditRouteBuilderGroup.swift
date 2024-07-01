import Architecture
import LinkNavigator

// MARK: - CreditRouteBuilderGroup

public struct CreditRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension CreditRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      CastRouteBuilder.generate(),
      CrewRouteBuilder.generate(),
      FanClubRouteBuilder.generate(),
    ]
  }
}
