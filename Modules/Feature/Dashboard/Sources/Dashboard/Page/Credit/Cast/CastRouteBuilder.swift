import Architecture
import LinkNavigator
import Domain

struct CastRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.cast.rawValue
    
    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.Credit.Request = items.decoded() else { return .none }
      
      return DebugWrappingController(matchPath: matchPath) {
        CastPage(store: .init(
          initialState: CastReducer.State(castItem: item),
          reducer: {
            CastReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
