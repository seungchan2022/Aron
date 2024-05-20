import Domain
import Foundation

// MARK: - MyListStub

public final class MyListStub { }

// MARK: MyListStub.Response

extension MyListStub {
  public struct Response: Equatable, Sendable {

    public init() { }

    public var localStore: MovieEntity.List =
      URLSerializedMockFunctor.serialized(url: Files.myListJson.url)!

  }

}
