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
  public var info: (MovieEntity.Person.Info.Request) -> AnyPublisher<MovieEntity.Person.Info.Response, CompositeErrorRepository> {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.personID)"],
        httpMethod: .get,
        content: .queryItemPath(PersonQueryItem()))
        .fetch(isDebug: true)
    }
  }

  public var image: (MovieEntity.Person.Image.Request) -> AnyPublisher<
    MovieEntity.Person.Image.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.personID)", "images"],
        httpMethod: .get,
        content: .queryItemPath(PersonQueryItem()))
        .fetch(isDebug: true)
    }
  }

  public var movieCredit: (MovieEntity.Person.MovieCredit.Request) -> AnyPublisher<
    MovieEntity.Person.MovieCredit.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.personID)", "movie_credits"],
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
      language: String = "ko-KR")
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
