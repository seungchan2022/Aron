// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Credit",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Credit",
      targets: ["Credit"]),
  ],
  dependencies: [
    .package(path: "../../../Core/Architecture"),
  ],
  targets: [
    .target(
      name: "Credit",
      dependencies: [
        "Architecture",
      ]),
    .testTarget(
      name: "CreditTests",
      dependencies: ["Credit"]),
  ])
