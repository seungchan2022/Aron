// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Aron",
  products: [
    .library(
      name: "Aron",
      targets: ["Aron"]),
  ],
  dependencies: [
    .package(url: "https://github.com/airbnb/swift", from: "1.0.6"),
  ],
  targets: [
    .target(
      name: "Aron"),
    .testTarget(
      name: "AronTests",
      dependencies: ["Aron"]),
  ])
