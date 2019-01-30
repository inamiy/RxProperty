// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxProperty",
    products: [
        .library(
            name: "RxProperty",
            targets: ["RxProperty"]),
    ],
    dependencies: [
         .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "RxProperty",
            dependencies: ["RxSwift", "RxCocoa"]),
        .testTarget(
            name: "RxPropertyTests",
            dependencies: ["RxProperty"]),
    ]
)
