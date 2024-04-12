import Architecture
import ComposableArchitecture
import Domain
import Foundation

struct GenreSideEffect {
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

extension GenreSideEffect {
  var getItem: (MovieEntity.MovieDetail.Genre.Request) -> Effect<GenreReducer.Action> {
    { request in
        .publisher {
          useCase.movieDetailUseCase.genre(request)
            .receive(on: main)
            .mapToResult()
            .map(GenreReducer.Action.fetchItem)
        }
    }
  }
  
  var routeToDetail: (MovieEntity.MovieDetail.Genre.Response.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}


extension MovieEntity.MovieDetail.Genre.Response.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: self.id)
  }
}
