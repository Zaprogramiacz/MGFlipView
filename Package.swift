// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FlipView",
  platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
  products: [.library(name: "FlipView", targets: ["FlipView"])],
  dependencies: [],
  targets: [
    .target(name: "FlipView", dependencies: []),
    .testTarget(name: "FlipViewTests", dependencies: ["FlipView"])
  ]
)
