// MARK: - MovieEntity.Discover

extension MovieEntity {
  public enum Discover {
    public enum Movie { }
    public enum Genre { }
    public enum Keyword { }
  }
}

extension MovieEntity.Discover.Movie {
  public struct Request: Equatable, Codable, Sendable {
    public let apiKey: String
    public let language: String
    public let page: Int

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      page: Int = 1)
    {
      self.apiKey = apiKey
      self.language = language
      self.page = page
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case page

    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let page: Int
    public let itemList: [Item]
    public let totalPage: Int
    public let totalItemList: Int

    private enum CodingKeys: String, CodingKey {
      case page
      case itemList = "results"
      case totalPage = "total_pages"
      case totalItemList = "total_results"
    }
  }

  public struct Item: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let title: String
    public let poster: String

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case poster = "poster_path"
    }
  }
}

extension MovieEntity.Discover.Genre {

  public struct Request: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      genreID: Int,
      page: Int = 1,
      sortBy: String = "popularity.desc")
    {
      self.apiKey = apiKey
      self.language = language
      self.genreID = genreID
      self.page = page
      self.sortBy = sortBy
    }

    // MARK: Public

    public let apiKey: String
    public let language: String
    public let genreID: Int
    public let page: Int
    public let sortBy: String

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case genreID = "with_genres"
      case page
      case sortBy = "sort_by"
    }
  }

  public struct Response: Equatable, Codable, Sendable {

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
    public let releaseDate: String
    public let voteAverage: Double?
    public let overview: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case poster = "poster_path"
      case releaseDate = "release_date"
      case voteAverage = "vote_average"
      case overview
    }
  }
}

extension MovieEntity.Discover.Keyword {

  public struct Request: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      keywordID: Int,
      page: Int = 1)
    {
      self.apiKey = apiKey
      self.language = language
      self.keywordID = keywordID
      self.page = page
    }

    // MARK: Public

    public let apiKey: String
    public let language: String
    public let keywordID: Int
    public let page: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case keywordID = "with_keywords"
      case page
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
    public let releaseDate: String
    public let voteAverage: Double?
    public let overview: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case poster = "poster_path"
      case releaseDate = "release_date"
      case voteAverage = "vote_average"
      case overview
    }
  }
}
