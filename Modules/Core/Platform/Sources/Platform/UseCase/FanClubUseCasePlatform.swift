import Combine
import Domain

// MARK: - FanClubUseCasePlatform

public struct FanClubUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.themoviedb.org/3/person") {
    self.baseURL = baseURL
  }
}

// MARK: FanClubUseCase

extension FanClubUseCasePlatform: FanClubUseCase {
  public var fanClub: (MovieEntity.FanClub.Request) -> AnyPublisher<MovieEntity.FanClub.Response, CompositeErrorRepository> {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["popular"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }
}
