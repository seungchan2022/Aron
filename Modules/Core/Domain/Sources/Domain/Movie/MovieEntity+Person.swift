import Foundation

// MARK: - MovieEntity.Person

extension MovieEntity {
  public enum Person {
    public enum Info { }
    public enum Image { }
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

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profile = "profile_path"
      case department = "known_for_department"
      case knownAsList = "also_known_as"
      case birth = "place_of_birth"
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
