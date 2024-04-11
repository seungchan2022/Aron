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
