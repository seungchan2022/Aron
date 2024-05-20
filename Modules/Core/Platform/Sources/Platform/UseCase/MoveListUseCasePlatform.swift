import Combine
import Domain
import Foundation

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

extension Encodable {
  var prettyPrintedJSONString: String? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    guard let data = try? encoder.encode(self) else { return nil }
    return String(data: data, encoding: .utf8) ?? nil
  }
}
