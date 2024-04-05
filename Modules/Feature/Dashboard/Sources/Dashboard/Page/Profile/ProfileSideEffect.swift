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
  var item: (MovieEntity.Person.Info.Request) -> Effect<ProfileReducer.Action> {
    { request in
      .publisher {
        useCase.personUseCase.info(request)
          .receive(on: main)
          .mapToResult()
          .map(ProfileReducer.Action.fetchItem)
      }
    }
  }

  var profileImage: (MovieEntity.Person.Image.Request) -> Effect<ProfileReducer.Action> {
    { request in
      .publisher {
        useCase.personUseCase.image(request)
          .receive(on: main)
          .mapToResult()
          .map(ProfileReducer.Action.fetchProfileImage)
      }
    }
  }
}
