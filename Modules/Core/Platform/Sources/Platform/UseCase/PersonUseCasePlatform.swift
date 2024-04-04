import Combine
import Domain

// MARK: - PersonUseCasePlatform

public struct PersonUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.themoviedb.org/3/person") {
    self.baseURL = baseURL
  }
}

// MARK: PersonUseCase

extension PersonUseCasePlatform: PersonUseCase {
  public var person: (MovieEntity.Person.Request) -> AnyPublisher<MovieEntity.Person.Response, CompositeErrorRepository> {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.personID)"],
        httpMethod: .get,
        content: .queryItemPath(PersonQueryItem()))
        .fetch(isDebug: true)
    }
  }
}

// MARK: PersonUseCasePlatform.PersonQueryItem

extension PersonUseCasePlatform {
  fileprivate struct PersonQueryItem: Equatable, Codable, Sendable {
    public let apiKey: String
    public let language: String

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-US")
    {
      self.apiKey = apiKey
      self.language = language
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
    }
  }
}
