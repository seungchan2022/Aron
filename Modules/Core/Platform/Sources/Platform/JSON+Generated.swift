// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - Files

// swiftlint:disable superfluous_disable_command file_length line_length implicit_return

// swiftlint:disable explicit_type_interface identifier_name
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum Files {
  /// dummy.json
  static let dummyJson = File(name: "dummy", ext: "json", relativePath: "", mimeType: "application/json")
  /// movie_detail_credit_failure.json
  static let movieDetailCreditFailureJson = File(
    name: "movie_detail_credit_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_credit_success.json
  static let movieDetailCreditSuccessJson = File(
    name: "movie_detail_credit_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_movie_card_failure.json
  static let movieDetailMovieCardFailureJson = File(
    name: "movie_detail_movie_card_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_movie_card_success.json
  static let movieDetailMovieCardSuccessJson = File(
    name: "movie_detail_movie_card_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_recommended_failure.json
  static let movieDetailRecommendedFailureJson = File(
    name: "movie_detail_recommended_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_recommended_success.json
  static let movieDetailRecommendedSuccessJson = File(
    name: "movie_detail_recommended_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_review_failure.json
  static let movieDetailReviewFailureJson = File(
    name: "movie_detail_review_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_review_success.json
  static let movieDetailReviewSuccessJson = File(
    name: "movie_detail_review_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_similar_failure.json
  static let movieDetailSimilarFailureJson = File(
    name: "movie_detail_similar_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_detail_similar_success.json
  static let movieDetailSimilarSuccessJson = File(
    name: "movie_detail_similar_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_genre_list_failure.json
  static let movieGenreListFailureJson = File(
    name: "movie_genre_list_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_genre_list_success.json
  static let movieGenreListSuccessJson = File(
    name: "movie_genre_list_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_now_playing_failure.json
  static let movieNowPlayingFailureJson = File(
    name: "movie_now_playing_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_now_playing_success.json
  static let movieNowPlayingSuccessJson = File(
    name: "movie_now_playing_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_popular_failure.json
  static let moviePopularFailureJson = File(
    name: "movie_popular_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_popular_success.json
  static let moviePopularSuccessJson = File(
    name: "movie_popular_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_top_rated_failure.json
  static let movieTopRatedFailureJson = File(
    name: "movie_top_rated_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_top_rated_success.json
  static let movieTopRatedSuccessJson = File(
    name: "movie_top_rated_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_trending_failure.json
  static let movieTrendingFailureJson = File(
    name: "movie_trending_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_trending_success.json
  static let movieTrendingSuccessJson = File(
    name: "movie_trending_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_upcoming_failure.json
  static let movieUpcomingFailureJson = File(
    name: "movie_upcoming_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// movie_upcoming_success.json
  static let movieUpcomingSuccessJson = File(
    name: "movie_upcoming_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// search_keyword_failure.json
  static let searchKeywordFailureJson = File(
    name: "search_keyword_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// search_keyword_success.json
  static let searchKeywordSuccessJson = File(
    name: "search_keyword_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// search_movie_failure.json
  static let searchMovieFailureJson = File(
    name: "search_movie_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// search_movie_success.json
  static let searchMovieSuccessJson = File(
    name: "search_movie_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// search_person_failure.json
  static let searchPersonFailureJson = File(
    name: "search_person_failure",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
  /// search_person_success.json
  static let searchPersonSuccessJson = File(
    name: "search_person_success",
    ext: "json",
    relativePath: "",
    mimeType: "application/json")
}

// MARK: - File

// swiftlint:enable explicit_type_interface identifier_name
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

struct File {
  let name: String
  let ext: String?
  let relativePath: String
  let mimeType: String

  var url: URL {
    url(locale: nil)
  }

  var path: String {
    path(locale: nil)
  }

  func url(locale: Locale?) -> URL {
    let bundle = BundleToken.bundle
    let url = bundle.url(
      forResource: name,
      withExtension: ext,
      subdirectory: relativePath,
      localization: locale?.identifier)
    guard let result = url else {
      let file = name + (ext.flatMap { ".\($0)" } ?? "")
      fatalError("Could not locate file named \(file)")
    }
    return result
  }

  func path(locale: Locale?) -> String {
    url(locale: locale).path
  }
}

// MARK: - BundleToken

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
