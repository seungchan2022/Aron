import Foundation

// MARK: - Link.Credit

extension Link {
  public enum Credit { }
}

// MARK: - Link.Credit.Path

extension Link.Credit {
  public enum Path: String, Equatable {
    case cast
    case crew
    case fanClub
  }
}
