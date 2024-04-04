import Foundation

// MARK: - MovieEntity.Person

extension MovieEntity {
  public enum Person { }
}

extension MovieEntity.Person {
  public struct Request: Equatable, Codable, Sendable {
    public let personID: Int

    public init(personID: Int) {
      self.personID = personID
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let id: Int
    public let name: String
    public let profile: String?
    public let department: String
    public let birth: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profile = "profile_path"
      case department = "known_for_department"
      case birth = "place_of_birth"
    }
  }
}
