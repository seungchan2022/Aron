import Foundation

// MARK: - Link.Dashboard

extension Link {
  public enum Dashboard { }
}

// MARK: - Link.Dashboard.Path

extension Link.Dashboard {
  public enum Path: String, Equatable {
    case nowPlaying
    case similar
    case movieDetail
    case review
    case cast
    case crew
    case otherPoster
    case discover
    case fanClub
    case profile
    case myList
    case newList
  }
}
