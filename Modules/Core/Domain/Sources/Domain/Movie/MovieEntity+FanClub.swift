import Foundation

// MARK: - MovieEntity.FanClub

extension MovieEntity {
  public enum FanClub { }
}

extension MovieEntity.FanClub {
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
