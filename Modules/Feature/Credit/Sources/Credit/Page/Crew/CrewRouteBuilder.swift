import Architecture
import Domain
import LinkNavigator

struct CrewRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Credit.Path.crew.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: CreditEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.Credit.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        CrewPage(store: .init(
          initialState: CrewReducer.State(crewItem: item),
          reducer: {
            CrewReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
