import Foundation

// MARK: - Link.Person

extension Link {
  public enum Person { }
}

// MARK: - Link.Person.Path

extension Link.Person {
  public enum Path: String, Equatable {
    case cast
    case crew
    case fanClub
    case profile
  }
}
