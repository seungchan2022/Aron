// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Platform",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "Platform",
      targets: ["Platform"]),
  ],
  dependencies: [
    .package(path: "../../Core/Domain"),
    .package(
      url: "https://github.com/CombineCommunity/CombineExt.git",
      .upToNextMajor(from: "1.8.1")),
    .package(
      url: "https://github.com/apple/swift-log.git",
      .upToNextMajor(from: "1.5.3")),
  ],
  targets: [
    .target(
      name: "Platform",
      dependencies: [
        "Domain",
        "CombineExt",
        .product(name: "Logging", package: "swift-log"),
      ],
      resources: [
        .copy("Resources/Mock/dummy.json"),
        .copy("Resources/Mock/movie_now_playing_success.json"),
        .copy("Resources/Mock/movie_now_playing_failure.json"),
        .copy("Resources/Mock/movie_upcoming_success.json"),
        .copy("Resources/Mock/movie_upcoming_failure.json"),
        .copy("Resources/Mock/movie_trending_success.json"),
        .copy("Resources/Mock/movie_trending_failure.json"),
        .copy("Resources/Mock/movie_popular_success.json"),
        .copy("Resources/Mock/movie_popular_failure.json"),
        .copy("Resources/Mock/movie_top_rated_success.json"),
        .copy("Resources/Mock/movie_top_rated_failure.json"),
        .copy("Resources/Mock/movie_genre_list_success.json"),
        .copy("Resources/Mock/movie_genre_list_failure.json"),
        .copy("Resources/Mock/search_keyword_success.json"),
        .copy("Resources/Mock/search_keyword_failure.json"),
        .copy("Resources/Mock/search_movie_success.json"),
        .copy("Resources/Mock/search_movie_failure.json"),
        .copy("Resources/Mock/search_person_success.json"),
        .copy("Resources/Mock/search_person_failure.json"),
        .copy("Resources/Mock/movie_detail_movie_card_success.json"),
        .copy("Resources/Mock/movie_detail_movie_card_failure.json"),
        .copy("Resources/Mock/movie_detail_review_success.json"),
        .copy("Resources/Mock/movie_detail_review_failure.json"),
        .copy("Resources/Mock/movie_detail_credit_success.json"),
        .copy("Resources/Mock/movie_detail_credit_failure.json"),
        .copy("Resources/Mock/movie_detail_similar_success.json"),
        .copy("Resources/Mock/movie_detail_similar_failure.json"),
        .copy("Resources/Mock/movie_detail_recommended_success.json"),
        .copy("Resources/Mock/movie_detail_recommended_failure.json"),
        .copy("Resources/Mock/movie_discover_genre_success.json"),
        .copy("Resources/Mock/movie_discover_genre_failure.json"),
        .copy("Resources/Mock/movie_discover_keyword_success.json"),
        .copy("Resources/Mock/movie_discover_keyword_failure.json"),
      ]),
    .testTarget(
      name: "PlatformTests",
      dependencies: ["Platform"]),
  ])
