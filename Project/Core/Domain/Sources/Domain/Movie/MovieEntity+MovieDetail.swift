// MARK: - MovieEntity.MovieDetail

extension MovieEntity {
  public enum MovieDetail {
    public enum MovieCard { }
    public enum Review { }
    public enum Credit { }
    public enum SimilarMovie { }
    public enum RecommendedMovie { }
  }
}

extension MovieEntity.MovieDetail.MovieCard {

  public struct PathList: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
    }
  }

  public struct QueryItemPath: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      includeImageLanguage: String = "ko,ko,null",
      appendToResponse: String = "keywords,images")
    {
      self.apiKey = apiKey
      self.language = language
      self.includeImageLanguage = includeImageLanguage
      self.appendToResponse = appendToResponse
    }

    // MARK: Public

    public let apiKey: String
    public let language: String
    public let includeImageLanguage: String
    public let appendToResponse: String

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case includeImageLanguage = "include_image_language"
      case appendToResponse = "append_to_response"
    }
  }

  public struct Response: Equatable, Codable, Sendable, Identifiable {

    // MARK: Public

    public let id: Int
    public let title: String
    public let releaseDate: String
    public let runtime: Int
    public let status: String
    public let productionCountryList: [ProductionCountryItem]
    public let voteAverage: Double
    public let voteCount: Int
    public let genreItemList: [GenreItem]
    public let overview: String
    public let keywordBucket: KeywordItemList

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case releaseDate = "release_date"
      case runtime
      case status
      case productionCountryList = "production_countries"
      case voteAverage = "vote_average"
      case voteCount = "vote_count"
      case genreItemList = "genres"
      case overview
      case keywordBucket = "keywords"
    }
  }

  public struct ProductionCountryItem: Equatable, Codable, Sendable {
    public let name: String

    private enum CodingKeys: String, CodingKey {
      case name
    }
  }

  public struct GenreItem: Equatable, Identifiable, Codable, Sendable {
    public let id: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
    }
  }

  public struct KeywordItemList: Equatable, Codable, Sendable {
    public let keywordItem: [KeywordItem]?

    private enum CodingKeys: String, CodingKey {
      case keywordItem = "keywords"
    }
  }

  public struct KeywordItem: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
    }
  }
}

// MARK: - MovieEntity.MovieDetail.MovieCard.Request

extension MovieEntity.MovieDetail.MovieCard {
  public struct Request: Equatable, Sendable, Codable {
    public let pathList: MovieEntity.MovieDetail.MovieCard.PathList
    public let queryItemPath: MovieEntity.MovieDetail.MovieCard.QueryItemPath

    public init(
      pathList: MovieEntity.MovieDetail.MovieCard.PathList,
      queryItemPath: MovieEntity.MovieDetail.MovieCard.QueryItemPath)
    {
      self.pathList = pathList
      self.queryItemPath = queryItemPath
    }
  }
}

extension MovieEntity.MovieDetail.Review {

  public struct PathList: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
    }
  }

  public struct QueryItemPath: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "en-US")
    {
      self.apiKey = apiKey
      self.language = language
    }

    // MARK: Public

    public let apiKey: String
    public let language: String

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language

    }
  }

  public struct Response: Equatable, Codable, Sendable, Identifiable {

    // MARK: Public

    public let id: Int
    public let totalItemListCount: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case totalItemListCount = "total_results"
    }
  }
}

// MARK: - MovieEntity.MovieDetail.Review.Request

extension MovieEntity.MovieDetail.Review {
  public struct Request: Equatable, Sendable, Codable {
    public let pathList: MovieEntity.MovieDetail.Review.PathList
    public let queryItemPath: MovieEntity.MovieDetail.Review.QueryItemPath

    public init(
      pathList: MovieEntity.MovieDetail.Review.PathList,
      queryItemPath: MovieEntity.MovieDetail.Review.QueryItemPath)
    {
      self.pathList = pathList
      self.queryItemPath = queryItemPath
    }
  }
}

extension MovieEntity.MovieDetail.Credit {

  public struct PathList: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
    }
  }

  public struct QueryItemPath: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "en-US")
    {
      self.apiKey = apiKey
      self.language = language
    }

    // MARK: Public

    public let apiKey: String
    public let language: String

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
    }
  }

  public struct Response: Equatable, Codable, Sendable, Identifiable {

    // MARK: Public

    public let id: Int
    public let castItemList: [CastItem]
    public let crewItemList: [CrewItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case castItemList = "cast"
      case crewItemList = "crew"
    }
  }

  public struct CastItem: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let character: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case character
    }
  }

  public struct CrewItem: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let department: String
    public let job: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case department = "known_for_department"
      case job
    }
  }
}

// MARK: - MovieEntity.MovieDetail.Credit.Request

extension MovieEntity.MovieDetail.Credit {
  public struct Request: Equatable, Sendable, Codable {
    public let pathList: MovieEntity.MovieDetail.Credit.PathList
    public let queryItemPath: MovieEntity.MovieDetail.Credit.QueryItemPath

    public init(
      pathList: MovieEntity.MovieDetail.Credit.PathList,
      queryItemPath: MovieEntity.MovieDetail.Credit.QueryItemPath)
    {
      self.pathList = pathList
      self.queryItemPath = queryItemPath
    }
  }
}
