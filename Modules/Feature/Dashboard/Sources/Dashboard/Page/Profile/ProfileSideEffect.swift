import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ProfileSideEffect

struct ProfileSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension ProfileSideEffect {
  var item: (MovieEntity.Person.Request) -> Effect<ProfileReducer.Action> {
    { request in
      .publisher {
        useCase.personUseCase.person(request)
          .receive(on: main)
          .mapToResult()
          .map(ProfileReducer.Action.fetchItem)
      }
    }
  }
}
