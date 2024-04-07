import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - OtherPosterSideEffect

struct OtherPosterSideEffect {
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

extension OtherPosterSideEffect {

  var item: (MovieEntity.MovieDetail.MovieCard.Request) -> Effect<OtherPosterReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.movieCard(request)
          .receive(on: main)
          .mapToResult()
          .map(OtherPosterReducer.Action.fetchItem)
      }
    }
  }

  var routeToBack: () -> Void {
    {
      navigator.close(
        isAnimated: false,
        completeAction: { })
    }
  }
}
