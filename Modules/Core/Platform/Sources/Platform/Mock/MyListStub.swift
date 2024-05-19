import Foundation
import Domain

public final class MyListStub {
}

extension MyListStub {
  public struct Response: Equatable, Sendable {
    
    public init() {}
    
    public var localStore: MovieEntity.List =
    URLSerializedMockFunctor.serialized(url: Files.myListJson.url)!
    
  }
  
}
