import Architecture
import Domain
import LinkNavigator

struct OtherPosterRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.otherPoster.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in

      guard let env: PersonEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.MovieCard.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        OtherPosterPage(store: .init(
          initialState: OtherPosterReducer.State(item: item),
          reducer: {
            OtherPosterReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
