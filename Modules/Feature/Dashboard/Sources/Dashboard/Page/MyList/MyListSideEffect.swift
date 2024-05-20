import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MyListSideEffect

public struct MyListSideEffect {
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

  var updateIsWish: (MovieEntity.MovieDetail.MovieCard.Response) -> Effect<MyListReducer.Action> {
    { item in
        .publisher {
          useCase.movieListUseCase.saveWishList(item)
            .map {
              $0.wishList.first(where: { $0 == item }) != .none
            }
            .receive(on: main)
            .mapToResult()
            .map(MyListReducer.Action.fetchIsWish)
        }
    }
  }
  
  var updateIsSeen: (MovieEntity.MovieDetail.MovieCard.Response) -> Effect<MyListReducer.Action> {
    { item in
        .publisher {
          useCase.movieListUseCase.saveSeenList(item)
            .map {
              $0.seenList.first(where: { $0 == item }) != .none
            }
            .receive(on: main)
            .mapToResult()
            .map(MyListReducer.Action.fetchIsSeen)
        }
    }
  }

  var sortedByReleaseDate: (MovieEntity.List) -> MovieEntity.List {
    { itemList in
      .init(
        wishList: (try? itemList.wishList.sorted(by: itemList.wishList.releaseDate)) ?? itemList.wishList,
        seenList: (try? itemList.seenList.sorted(by: itemList.seenList.releaseDate)) ?? itemList.seenList)
    }
  }
  
  var sortedByRating: (MovieEntity.List) -> MovieEntity.List {
    { itemList in
      .init(
        wishList: (try? itemList.wishList.sorted(by: itemList.wishList.rating)) ?? itemList.wishList,
        seenList: (try? itemList.seenList.sorted(by: itemList.seenList.rating)) ?? itemList.seenList)
    }
  }
  
  var sortedByPopularity: (MovieEntity.List) -> MovieEntity.List {
    { itemList in
      .init(
        wishList: (try? itemList.wishList.sorted(by: itemList.wishList.popularity)) ?? itemList.wishList,
        seenList: (try? itemList.seenList.sorted(by: itemList.seenList.popularity)) ?? itemList.seenList)
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
