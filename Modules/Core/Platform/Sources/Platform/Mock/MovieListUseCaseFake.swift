import Combine
import Domain

// MARK: - MovieListUseCaseFake

public class MovieListUseCaseFake {

  // MARK: Lifecycle

  public init(store: MovieEntity.List = .init()) {
    self.store = store
  }

  // MARK: Public

  public func reset(store: MovieEntity.List = .init()) {
    self.store = store
  }

  // MARK: Private

  private var store: MovieEntity.List
}

// MARK: MovieListUseCase

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

  public var saveWishList: (MovieEntity.MovieDetail.MovieCard.Response) -> AnyPublisher<
    MovieEntity.List,
    CompositeErrorRepository
  > {
    { model in
      self.store = self.store.mutateWishItem(item: model)
      return Just(self.store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }

  public var saveSeenList: (MovieEntity.MovieDetail.MovieCard.Response) -> AnyPublisher<
    MovieEntity.List,
    CompositeErrorRepository
  > {
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
