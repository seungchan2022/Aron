import Architecture
import Domain
import LinkNavigator

struct ProfileRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Person.Path.profile.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.Person.Info.Request = items.decoded() else { return .none }
      guard let profileImageItem: MovieEntity.Person.Image.Request = items.decoded() else { return .none }
      guard let movieCreditItem: MovieEntity.Person.MovieCredit.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        ProfilePage(store: .init(
          initialState: ProfileReducer.State(
            item: item,
            profileImageItem: profileImageItem,
            movieCreditItem: movieCreditItem),
          reducer: {
            ProfileReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
