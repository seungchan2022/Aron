// MARK: - MovieEntity.Search

extension MovieEntity {
  public enum Search {
    public enum Movie { }
    public enum Person { }
    public enum Keyword { }
  }
}

extension MovieEntity.Search.Movie {
  public struct Request: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      page: Int = 1,
      query: String)
    {
      self.apiKey = apiKey
      self.language = language
      self.page = page
      self.query = query
    }

    // MARK: Public

    public let apiKey: String
    public let language: String
    public let page: Int
    public let query: String

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case page
      case query
    }
  }

  public struct Response: Equatable, Codable, Sendable {

    // MARK: Public

    public let page: Int
    public let itemList: [Item]
    public let totalPage: Int
    public let totalResultListCount: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case page
      case itemList = "results"
      case totalPage = "total_pages"
      case totalResultListCount = "total_results"
    }
  }

  public struct Item: Equatable, Identifiable, Codable, Sendable {
    public let id: Int
    public let title: String
    public let poster: String?
    public let voteAverage: Double?
    public let releaseDate: String
    public let overview: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case poster = "poster_path"
      case voteAverage = "vote_average"
      case releaseDate = "release_date"
      case overview
    }
  }
}

// MARK: - MovieEntity.Search.Movie.Composite

extension MovieEntity.Search.Movie {
  public struct Composite: Equatable, Sendable {
    public let request: MovieEntity.Search.Movie.Request
    public let response: MovieEntity.Search.Movie.Response

    public init(
      request: MovieEntity.Search.Movie.Request,
      response: MovieEntity.Search.Movie.Response)
    {
      self.request = request
      self.response = response
    }
  }
}

extension MovieEntity.Search.Keyword {
  public struct Request: Equatable, Codable, Sendable {
    public let apiKey: String
    public let language: String
    public let query: String

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      query: String)
    {
      self.apiKey = apiKey
      self.language = language
      self.query = query
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case query
    }
  }

  public struct Response: Equatable, Codable, Sendable {

    // MARK: Public

    public let page: Int
    public let itemList: [Item]
    public let totalPage: Int
    public let totalResultListCount: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case page
      case itemList = "results"
      case totalPage = "total_pages"
      case totalResultListCount = "total_results"
    }
  }

  public struct Item: Equatable, Identifiable, Codable, Sendable {
    public let id: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
    }
  }
}

// MARK: - MovieEntity.Search.Keyword.Composite

extension MovieEntity.Search.Keyword {
  public struct Composite: Equatable, Sendable {
    public let request: MovieEntity.Search.Keyword.Request
    public let response: MovieEntity.Search.Keyword.Response

    public init(
      request: MovieEntity.Search.Keyword.Request,
      response: MovieEntity.Search.Keyword.Response)
    {
      self.request = request
      self.response = response
    }
  }
}

extension MovieEntity.Search.Person {
  public struct Request: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      query: String ,
      page: Int = 1)
    {
      self.apiKey = apiKey
      self.language = language
      self.query = query
      self.page = page
    }

    // MARK: Public

    public let apiKey: String
    public let language: String
    public let query: String
    public let page: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case query
      case page
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let page: Int
    public let itemList: [Item]
    public let totalPage: Int
    public let totalResultListCount: Int

    private enum CodingKeys: String, CodingKey {
      case page
      case itemList = "results"
      case totalPage = "total_pages"
      case totalResultListCount = "total_results"
    }
  }

  public struct Item: Equatable, Identifiable, Codable, Sendable {
    public let id: Int
    public let name: String
    public let profileImageURL: String?
    public let filmList: [FilmItem]

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profileImageURL = "profile_path"
      case filmList = "known_for"
    }
  }

  public struct FilmItem: Equatable, Identifiable, Codable, Sendable {
    public let id: Int
    public let title: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case title
    }
  }
}

// MARK: - MovieEntity.Search.Person.Composite

extension MovieEntity.Search.Person {
  public struct Composite: Equatable, Sendable {
    public let request: MovieEntity.Search.Person.Request
    public let response: MovieEntity.Search.Person.Response

    public init(
      request: MovieEntity.Search.Person.Request,
      response: MovieEntity.Search.Person.Response)
    {
      self.request = request
      self.response = response
    }
  }
}
