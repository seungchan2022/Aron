import Foundation

// MARK: - Link.Dashboard

extension Link {
  public enum Dashboard { }
}

// MARK: - Link.Dashboard.Path

extension Link.Dashboard {
  public enum Path: String, Equatable {
    case nowPlaying
    case movieDetail
    case discover
    case fanClub
    case myList
  }
}
