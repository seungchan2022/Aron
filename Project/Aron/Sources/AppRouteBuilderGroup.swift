import Architecture
import Common
import Credit
import Foundation
import LinkNavigator
import Movie
import My

struct AppRouteBuilderGroup<RootNavigator: RootNavigatorType> {

  var release: [RouteBuilderOf<RootNavigator>] {
    CommonRouteBuilderGroup.release
      + MyRouteBuilderGroup.release
      + CreditRouteBuilderGroup.release
      + MovieRouteBuilderGroup.release
  }
}
