import Architecture
import LinkNavigator
import Domain

struct ReviewRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.review.rawValue
    
    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.Review.Request = items.decoded() else { return .none }
      
      return DebugWrappingController(matchPath: matchPath) {
        ReviewPage(store: .init(
          initialState: ReviewReducer.State(reviewItem: item),
          reducer: {
            ReviewReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
