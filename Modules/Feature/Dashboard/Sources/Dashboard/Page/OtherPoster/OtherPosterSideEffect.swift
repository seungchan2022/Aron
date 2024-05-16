import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - OtherPosterSideEffect

public struct OtherPosterSideEffect {
  public let useCase: DashboardEnvironmentUsable
  public let main: AnySchedulerOf<DispatchQueue>
  public let navigator: RootNavigatorType

  public init(
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
