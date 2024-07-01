import Architecture
import Foundation
import LinkNavigator
import Movie

struct AppRouteBuilderGroup<RootNavigator: RootNavigatorType> {

  var release: [RouteBuilderOf<RootNavigator>] {
    MovieRouteBuilderGroup.release
  }
}
