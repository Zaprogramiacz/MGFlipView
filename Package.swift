// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MGFlipView",
  platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
  products: [.library(name: "MGFlipView", targets: ["MGFlipView"])],
  dependencies: [],
  targets: [
    .target(name: "MGFlipView", dependencies: []),
    .testTarget(name: "MGFlipViewTests", dependencies: ["MGFlipView"])
  ]
)
