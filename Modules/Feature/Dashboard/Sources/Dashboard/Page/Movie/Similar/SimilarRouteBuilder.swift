import Architecture
import LinkNavigator
import Domain

struct SimilarRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.similar.rawValue
    
    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      
      return DebugWrappingController(matchPath: matchPath) {
        SimilarPage(store: .init(
          initialState: SimilarReducer.State(),
          reducer: {
            SimilarReducer(sideEffect: .init(
                useCase: env,
                navigator: navigator))
          }))
      }
    }
  }
}
