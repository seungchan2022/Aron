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
}
