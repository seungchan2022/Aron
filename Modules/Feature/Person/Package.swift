// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Person",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Person",
      targets: ["Person"]),
  ],
  dependencies: [
    .package(path: "../../../Core/Architecture"),
  ],
  targets: [
    .target(
      name: "Person",
      dependencies: [
        "Architecture",
      ]),
    .testTarget(
      name: "PersonTests",
      dependencies: ["Person"]),
  ])
