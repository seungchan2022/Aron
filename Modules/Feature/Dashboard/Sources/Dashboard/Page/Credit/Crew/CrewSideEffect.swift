import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CrewSideEffect

struct CrewSideEffect {
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

extension CrewSideEffect {
  var crew: (MovieEntity.MovieDetail.Credit.Request) -> Effect<CrewReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.credit(request)
          .receive(on: main)
          .mapToResult()
          .map(CrewReducer.Action.fetchCrewItem)
      }
    }
  }
}
