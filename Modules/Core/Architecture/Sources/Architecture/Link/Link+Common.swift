import Foundation

// MARK: - Link.Common

extension Link {
  public enum Common { }
}

// MARK: - Link.Common.Path

extension Link.Common {
  public enum Path: String, Equatable {
    case movieDetail
    case review
    case otherPoster
    case profile
  }
}
