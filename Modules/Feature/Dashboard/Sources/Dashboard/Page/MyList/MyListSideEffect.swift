import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MyListSideEffect

struct MyListSideEffect {
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

extension MyListSideEffect {
  var getItemList: () -> Effect<MyListReducer.Action> {
    {
      .publisher {
        useCase.movieListUseCase.getItemList()
          .receive(on: main)
          .mapToResult()
          .map(MyListReducer.Action.fetchItemList)
      }
    }
  }

  var routeToNewList: () -> Void {
    {
      navigator.sheet(
        linkItem: .init(path: Link.Dashboard.Path.newList.rawValue),
        isAnimated: true)
    }
  }

  var routeToDetail: (MovieEntity.MovieDetail.MovieCard.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.MovieCard.Response {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}
