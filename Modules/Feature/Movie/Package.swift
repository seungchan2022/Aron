// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Movie",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Movie",
      targets: ["Movie"]),
  ],
  dependencies: [
    .package(path: "../../../Core/Architecture"),
  ],
  targets: [
    .target(
      name: "Movie",
      dependencies: [
        "Architecture",
      ]),
    .testTarget(
      name: "MovieTests",
      dependencies: ["Movie"]),
  ])
