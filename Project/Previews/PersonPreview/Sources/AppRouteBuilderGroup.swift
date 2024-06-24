import Architecture
import Foundation
import LinkNavigator
import Person

struct AppRouteBuilderGroup<RootNavigator: RootNavigatorType> {

  var release: [RouteBuilderOf<RootNavigator>] {
    PersonRouteBuilderGroup.release
      + PersonRouteBuilderGroup.template
  }
}
