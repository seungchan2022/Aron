import Combine
import Domain

// MARK: - MovieListUseCasePlatform

public struct MovieListUseCasePlatform {
  @StandardKeyArchiver(defaultValue: MovieEntity.List())

  private var store: MovieEntity.List

  public init() { }
}

// MARK: MovieListUseCase

extension MovieListUseCasePlatform: MovieListUseCase {
  public var getIsWishLike: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    {
      Just(store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }

  public var getIsSeenLike: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    {
      Just(store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }

  public var saveWishList: (MovieEntity.MovieDetail.MovieCard.Response) -> AnyPublisher<
    MovieEntity.List,
    CompositeErrorRepository
  > {
    { model in
      _store.sync(store.mutateWishItem(item: model))
      return Just(store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }

  public var saveSeenList: (MovieEntity.MovieDetail.MovieCard.Response) -> AnyPublisher<
    MovieEntity.List,
    CompositeErrorRepository
  > {
    {
      model in
      _store.sync(store.mutateSeenItem(item: model))

      return Just(store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }

  public var getItemList: () -> AnyPublisher<MovieEntity.List, CompositeErrorRepository> {
    {
      Just(store)
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
        seenList: seenList)
    }
    return .init(
      wishList: wishList.filter { $0.id != item.id },
      seenList: seenList)
  }

  fileprivate func mutateSeenItem(item: MovieEntity.MovieDetail.MovieCard.Response) -> Self {
    guard seenList.first(where: { $0.id == item.id }) != .none else {
      return .init(
        wishList: wishList,
        seenList: seenList + [item])
    }
    return .init(
      wishList: wishList,
      seenList: seenList.filter { $0.id != item.id })
  }
}
