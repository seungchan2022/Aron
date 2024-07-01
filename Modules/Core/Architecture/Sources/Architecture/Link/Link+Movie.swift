import Foundation

// MARK: - Link.Movie

extension Link {
  public enum Movie { }
}

// MARK: - Link.Movie.Path

extension Link.Movie {
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
    case discover
    case setting
  }
}
