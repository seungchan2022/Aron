// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "My",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "My",
      targets: ["My"]),
  ],
  dependencies: [
    .package(path: "../../../Core/Architecture"),
  ],
  targets: [
    .target(
      name: "My",
      dependencies: [
        "Architecture",
      ]),
    .testTarget(
      name: "MyTests",
      dependencies: ["My"]),
  ])
