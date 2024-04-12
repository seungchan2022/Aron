// MARK: - MovieEntity.MovieDetail

extension MovieEntity {
  public enum MovieDetail {
    public enum MovieCard { }
    public enum Review { }
    public enum Credit { }
    public enum SimilarMovie { }
    public enum RecommendedMovie { }
    public enum Genre { }
    public enum Keyword { }
  }
}

extension MovieEntity.MovieDetail.MovieCard {

  public struct Request: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
    }
  }

  public struct Response: Equatable, Codable, Sendable, Identifiable {

    // MARK: Public

    public let id: Int
    public let title: String
    public let poster: String?
    public let backdrop: String?
    public let releaseDate: String
    public let runtime: Int
    public let status: String
    public let productionCountryList: [ProductionCountryItem]
    public let voteAverage: Double?
    public let voteCount: Int
    public let genreItemList: [GenreItem]
    public let overview: String?
    public let keywordBucket: KeywordItemList
    public let imageBucket: ImageBucket

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case poster = "poster_path"
      case backdrop = "backdrop_path"
      case releaseDate = "release_date"
      case runtime
      case status
      case productionCountryList = "production_countries"
      case voteAverage = "vote_average"
      case voteCount = "vote_count"
      case genreItemList = "genres"
      case overview
      case keywordBucket = "keywords"
      case imageBucket = "images"
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

  public struct ImageBucket: Equatable, Codable, Sendable {
    public let backdropImageList: [BackdropImageItem]?
    public let otherPosterItemList: [PosterItem]?

    private enum CodingKeys: String, CodingKey {
      case backdropImageList = "backdrops"
      case otherPosterItemList = "posters"
    }
  }

  public struct BackdropImageItem: Equatable, Codable, Sendable {
    public let image: String?

    private enum CodingKeys: String, CodingKey {
      case image = "file_path"
    }
  }

  public struct PosterItem: Equatable, Codable, Sendable {
    public let image: String?

    private enum CodingKeys: String, CodingKey {
      case image = "file_path"
    }
  }

}

extension MovieEntity.MovieDetail.Review {

  public struct Request: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
    }
  }

  public struct Response: Equatable, Codable, Sendable, Identifiable {

    // MARK: Public

    public let id: Int
    public let itemList: [Item]
    public let totalItemListCount: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case itemList = "results"
      case totalItemListCount = "total_results"
    }
  }

  public struct Item: Equatable, Codable, Sendable {
    public let author: String
    public let content: String
  }
}

extension MovieEntity.MovieDetail.Credit {

  public struct Request: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
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
    public let profile: String?
    public let character: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profile = "profile_path"
      case character
    }
  }

  public struct CrewItem: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let profile: String?
    public let department: String
    public let job: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profile = "profile_path"
      case department = "known_for_department"
      case job
    }
  }
}

extension MovieEntity.MovieDetail.SimilarMovie {

  public struct Request: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
    }
  }

  public struct Response: Equatable, Codable, Sendable {

    // MARK: Public

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

extension MovieEntity.MovieDetail.RecommendedMovie {

  public struct Request: Equatable, Codable, Sendable {
    public let movieID: Int

    public init(movieID: Int) {
      self.movieID = movieID
    }
  }

  public struct Response: Equatable, Codable, Sendable {

    // MARK: Public

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

extension MovieEntity.MovieDetail.Genre {

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

    // MARK: Public

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

extension MovieEntity.MovieDetail.Keyword {

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
