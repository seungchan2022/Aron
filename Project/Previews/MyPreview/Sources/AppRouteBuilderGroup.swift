import Architecture
import Foundation
import LinkNavigator
import My

struct AppRouteBuilderGroup<RootNavigator: RootNavigatorType> {

  var release: [RouteBuilderOf<RootNavigator>] {
    MyRouteBuilderGroup.release
      + MyRouteBuilderGroup.template
  }
}
