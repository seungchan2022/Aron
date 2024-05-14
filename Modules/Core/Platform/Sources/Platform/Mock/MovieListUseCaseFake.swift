import Combine
import Domain

public class MovieListUseCaseFake  {
  
  public init(store: MovieEntity.List = .init()) {
    self.store = store
  }
  
  public func reset(store: MovieEntity.List = .init()) {
    self.store = store
  }
  
  private var store: MovieEntity.List
}

extension MovieListUseCaseFake: MovieListUseCase {
  public var getIsWishLike: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    {
      Just(self.store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }
  
  public var getIsSeenLike: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    {
      Just(self.store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }
  
  public var saveWishList: (MovieEntity.MovieDetail.MovieCard.Response) -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    { model in
      self.store = self.store.mutateWishItem(item: model)
      return Just(self.store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }
  
  public var saveSeenList: (MovieEntity.MovieDetail.MovieCard.Response) -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    { model in
      self.store = self.store.mutateSeenItem(item: model)
      return Just(self.store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }
  
  public var getItemList: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    {
      Just(self.store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }
}



extension MovieEntity.List {

  fileprivate func mutateWishItem(item: MovieEntity.MovieDetail.MovieCard.Response) -> Self {
    guard wishList.first(where: { $0.id == item.id }) != .none else {
      return .init(
        wishList: wishList + [item],
        seenList: seenList.filter { $0.id != item.id })
    }
    return .init(
      wishList: wishList.filter { $0.id != item.id },
      seenList: seenList)
  }

  fileprivate func mutateSeenItem(item: MovieEntity.MovieDetail.MovieCard.Response) -> Self {
    guard seenList.first(where: { $0.id == item.id }) != .none else {
      return .init(
        wishList: wishList.filter { $0.id != item.id },
        seenList: seenList + [item])
    }
    return .init(
      wishList: wishList,
      seenList: seenList.filter { $0.id != item.id })
  }
}
