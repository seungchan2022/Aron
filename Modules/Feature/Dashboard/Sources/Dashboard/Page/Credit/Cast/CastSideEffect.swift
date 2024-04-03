import Architecture
import ComposableArchitecture
import Domain
import Foundation

struct CastSideEffect {
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

extension CastSideEffect {
  var cast: (MovieEntity.MovieDetail.Credit.Request) -> Effect<CastReducer.Action> {
    { request in
        .publisher {
          useCase.movieDetailUseCase.credit(request)
            .receive(on: main)
            .mapToResult()
            .map(CastReducer.Action.fetchCastItem)
        }
    }
  }
}
