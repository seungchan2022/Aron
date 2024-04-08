import Architecture
import Domain
import Foundation
import ComposableArchitecture

struct UpcomingSideEffect {
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

extension UpcomingSideEffect {
  var getItem: (MovieEntity.Movie.Upcoming.Request) -> Effect<UpcomingReducer.Action> {
    { item in
        .publisher {
          useCase.movieUseCase.upcoming(item)
            .receive(on: main)
            .mapToResult()
            .map(UpcomingReducer.Action.fetchItem)
        }
    }
  }
  
  var routeToDetail: (MovieEntity.Movie.Upcoming.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Movie.Upcoming.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: self.id)
  }
}
