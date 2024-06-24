import Foundation

// MARK: - Link.Dashboard

extension Link {
  public enum Dashboard { }
}

// MARK: - Link.Dashboard.Path

extension Link.Dashboard {
  public enum Path: String, Equatable {
    case home
    case movieList
    case nowPlaying
    case upcoming
    case trending
    case popular
    case topRated
    case genreList
    case genre
    case keyword
    case similar
    case recommended
    case movieDetail
    case review
    case otherPoster
    case discover
    case setting
  }
}
