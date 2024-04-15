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

  var sortedByReleaseDate: ([MovieEntity.MovieDetail.MovieCard.Response]) -> [MovieEntity.MovieDetail.MovieCard.Response] {
    { itemList in
//      SortItem(
//        itemList: itemList,
//        process: itemList.releaseDate
//      )
      //        .sort()
      (try? itemList.sorted(by: itemList.releaseDate)) ?? itemList
    }
  }

  var sortedByRating: ([MovieEntity.MovieDetail.MovieCard.Response]) -> [MovieEntity.MovieDetail.MovieCard.Response] {
    { itemList in
      (try? itemList.sorted(by: itemList.rating)) ?? itemList
    }
  }

  var sortedByPopularity: ([MovieEntity.MovieDetail.MovieCard.Response]) -> [MovieEntity.MovieDetail.MovieCard.Response] {
    { itemList in
      (try? itemList.sorted(by: itemList.rating)) ?? itemList
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

// MARK: - MyListSideEffect.SortItem

extension MyListSideEffect {
  fileprivate struct SortItem<T: Equatable> {
    let itemList: [T]
    let process: (T, T) throws -> Bool

    func sort() -> [T] {
      (try? itemList.sorted(by: process)) ?? itemList
    }
  }
}

extension [MovieEntity.MovieDetail.MovieCard.Response] {
  fileprivate var releaseDate: (MovieEntity.MovieDetail.MovieCard.Response, MovieEntity.MovieDetail.MovieCard.Response) throws
    -> Bool
  {
    {
      $0.releaseDate.toDate ?? Date() > $1.releaseDate.toDate ?? Date()
    }
  }

  fileprivate var rating: (MovieEntity.MovieDetail.MovieCard.Response, MovieEntity.MovieDetail.MovieCard.Response) throws
    -> Bool
  {
    {
      $0.voteAverage ?? 0 > $1.voteAverage ?? 0
    }
  }

  fileprivate var popularity: (MovieEntity.MovieDetail.MovieCard.Response, MovieEntity.MovieDetail.MovieCard.Response) throws
    -> Bool
  {
    {
      $0.popularity > $1.popularity
    }
  }
}

extension String {
  fileprivate var toDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: self)
  }
}
