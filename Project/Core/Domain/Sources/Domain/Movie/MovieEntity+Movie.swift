// MARK: - MovieEntity.Movie

extension MovieEntity {
  public enum Movie {
    public enum NowPlaying { }
  }
}

extension MovieEntity.Movie.NowPlaying {
  public struct Request: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      region: String = "KR",
      page: Int = 1)
    {
      self.apiKey = apiKey
      self.language = language
      self.region = region
      self.page = page
    }

    // MARK: Public

    public let apiKey: String
    public let language: String
    public let region: String
    public let page: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case region
      case page
    }
  }

  public struct Response: Equatable, Codable, Sendable {

    // MARK: Public

    public struct Item: Equatable, Identifiable, Codable, Sendable {
      public let id: Int
      public let title: String
      public let voteAverage: Double
      public let releaseDate: String
      public let overview: String?

      private enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview
      }
    }

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
}
