import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - DiscoverSideEffect

struct DiscoverSideEffect {
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

extension DiscoverSideEffect {
  var getItem: (MovieEntity.Discover.Movie.Request) -> Effect<DiscoverReducer.Action> {
    { item in
      .publisher {
        useCase.movieDiscoverUseCase.movie(item)
          .receive(on: main)
          .mapToResult()
          .map(DiscoverReducer.Action.fetchItem)
      }
    }
  }
}
