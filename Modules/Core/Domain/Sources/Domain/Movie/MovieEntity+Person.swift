import Foundation

// MARK: - MovieEntity.Person

extension MovieEntity {
  public enum Person {
    public enum Info { }
    public enum Image { }
    public enum MovieCredit { }
  }
}

extension MovieEntity.Person.Info {
  public struct Request: Equatable, Codable, Sendable {
    public let personID: Int

    public init(personID: Int) {
      self.personID = personID
    }
  }

  public struct Response: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let profile: String?
    public let department: String
    public let knownAsList: [String]
    public let birth: String?
    public let biography: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profile = "profile_path"
      case department = "known_for_department"
      case knownAsList = "also_known_as"
      case birth = "place_of_birth"
      case biography
    }
  }
}

extension MovieEntity.Person.Image {
  public struct Request: Equatable, Codable, Sendable {
    public let personID: Int

    public init(personID: Int) {
      self.personID = personID
    }
  }

  public struct Response: Identifiable, Equatable, Codable, Sendable {
    public let id: Int
    public let profileItemList: [ProfileItem]

    private enum CodingKeys: String, CodingKey {
      case id
      case profileItemList = "profiles"
    }
  }

  public struct ProfileItem: Equatable, Codable, Sendable {
    public let profileImageURL: String?

    private enum CodingKeys: String, CodingKey {
      case profileImageURL = "file_path"
    }
  }
}

extension MovieEntity.Person.MovieCredit {
  public struct Request: Equatable, Codable, Sendable {
    public let personID: Int
    
    public init(personID: Int) {
      self.personID = personID
    }
  }
  
  public struct Response: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let castItemList: [CastItem]?
    public let crewItemList: [CrewItem]?
    
    private enum CodingKeys: String, CodingKey {
      case id
      case castItemList = "cast"
      case crewItemList = "crew"
    }
  }
  
  public struct CastItem: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let poster: String?
    public let title: String
    public let character: String?
    
    private enum CodingKeys: String, CodingKey {
      case id
      case poster = "poster_path"
      case title
      case character
    }
  }
  
  public struct CrewItem: Equatable, Codable, Sendable, Identifiable {
    public let id: Int
    public let poster: String?
    public let title: String
    public let department: String?
    
    private enum CodingKeys: String, CodingKey {
      case id
      case poster = "poster_path"
      case title
      case department
    }
  }
}
