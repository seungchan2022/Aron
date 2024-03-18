import Architecture
import LinkNavigator

struct MyListRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.myList.rawValue
    
    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      
      return DebugWrappingController(matchPath: matchPath) {
        MyListPage(store: .init(
          initialState: MyListReducer.State(),
          reducer: {
            MyListReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
