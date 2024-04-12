import Architecture
import ComposableArchitecture
import Domain
import Foundation

struct GenreListSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType
  
  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType) {
      self.useCase = useCase
      self.main = main
      self.navigator = navigator
    }
}

extension GenreListSideEffect {
  var getItem: (MovieEntity.Movie.GenreList.Request) -> Effect<GenreListReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.genreList(item)
            .receive(on: main)
            .mapToResult()
            .map(GenreListReducer.Action.fetchItem)
        }
    }
  }
}
