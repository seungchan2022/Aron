import Architecture
import Domain
import LinkNavigator

struct ReviewRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Common.Path.review.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: CommonEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.MovieCard.Response = items.decoded() else { return .none }

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
