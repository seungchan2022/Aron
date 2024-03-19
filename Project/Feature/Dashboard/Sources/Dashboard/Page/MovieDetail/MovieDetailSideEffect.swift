import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MovieDetailSideEffect

struct MovieDetailSideEffect {
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

extension MovieDetailSideEffect {
  var detail: (MovieEntity.MovieDetail.MovieCard.Request) -> Effect<MovieDetailReducer.Action> {
    { item in
      .publisher {
        useCase.movieDetailUseCase.movieCard(item)
          .receive(on: main)
          .mapToResult()
          .map(MovieDetailReducer.Action.fetchDetailItem)
      }
    }
  }
}