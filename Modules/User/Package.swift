// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "User",
  platforms: [.iOS(.v14), .macOS(.v10_15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "User",
      targets: ["User"])
  ],
  dependencies: [
    .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "5.5.1"),
    .package(name: "RxSwift", url: "https://github.com/ReactiveX/RxSwift.git", from: "6.2.0"),
    .package(path: "../Core")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "User",
      dependencies: [
        .product(name: "RealmSwift", package: "Realm"),
        .product(name: "RxSwift", package: "RxSwift"),
        "Core"
      ]),
    .testTarget(
      name: "UserTests",
      dependencies: ["User"])
  ]
)
