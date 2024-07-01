import Architecture
import Credit
import Foundation
import LinkNavigator

struct AppRouteBuilderGroup<RootNavigator: RootNavigatorType> {

  var release: [RouteBuilderOf<RootNavigator>] {
    CreditRouteBuilderGroup.release
  }
}
