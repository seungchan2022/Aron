// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length line_length implicit_return

// MARK: - Files

// swiftlint:disable explicit_type_interface identifier_name
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Files {
  /// dummy.json
  internal static let dummyJson = File(name: "dummy", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_genre_list_failure.json
  internal static let movieGenreListFailureJson = File(name: "movie_genre_list_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_genre_list_success.json
  internal static let movieGenreListSuccessJson = File(name: "movie_genre_list_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_now_playing_failure.json
  internal static let movieNowPlayingFailureJson = File(name: "movie_now_playing_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_now_playing_success.json
  internal static let movieNowPlayingSuccessJson = File(name: "movie_now_playing_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_popular_failure.json
  internal static let moviePopularFailureJson = File(name: "movie_popular_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_popular_success.json
  internal static let moviePopularSuccessJson = File(name: "movie_popular_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_top_rated_failure.json
  internal static let movieTopRatedFailureJson = File(name: "movie_top_rated_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_top_rated_success.json
  internal static let movieTopRatedSuccessJson = File(name: "movie_top_rated_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_trending_failure.json
  internal static let movieTrendingFailureJson = File(name: "movie_trending_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_trending_success.json
  internal static let movieTrendingSuccessJson = File(name: "movie_trending_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_upcoming_failure.json
  internal static let movieUpcomingFailureJson = File(name: "movie_upcoming_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_upcoming_success.json
  internal static let movieUpcomingSuccessJson = File(name: "movie_upcoming_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_keyword_failure.json
  internal static let searchKeywordFailureJson = File(name: "search_keyword_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_keyword_success.json
  internal static let searchKeywordSuccessJson = File(name: "search_keyword_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_movie_failure.json
  internal static let searchMovieFailureJson = File(name: "search_movie_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_movie_success.json
  internal static let searchMovieSuccessJson = File(name: "search_movie_success", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_person_failure.json
  internal static let searchPersonFailureJson = File(name: "search_person_failure", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_person_success.json
  internal static let searchPersonSuccessJson = File(name: "search_person_success", ext: "json", relativePath: "", mimeType: "application/json")
}
// swiftlint:enable explicit_type_interface identifier_name
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

internal struct File {
  internal let name: String
  internal let ext: String?
  internal let relativePath: String
  internal let mimeType: String

  internal var url: URL {
    return url(locale: nil)
  }

  internal func url(locale: Locale?) -> URL {
    let bundle = BundleToken.bundle
    let url = bundle.url(
      forResource: name,
      withExtension: ext,
      subdirectory: relativePath,
      localization: locale?.identifier
    )
    guard let result = url else {
      let file = name + (ext.flatMap { ".\($0)" } ?? "")
      fatalError("Could not locate file named \(file)")
    }
    return result
  }

  internal var path: String {
    return path(locale: nil)
  }

  internal func path(locale: Locale?) -> String {
    return url(locale: locale).path
  }
}

// swiftlint:disable convenience_type explicit_type_interface
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type explicit_type_interface
