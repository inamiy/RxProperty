// swift-tools-version:5.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "RxProperty",
    products: [
        .library(name: "RxProperty", targets: ["RxProperty"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "5.1.1"),
    ],
    targets: [
        .target(name: "RxProperty", dependencies: [
            "RxSwift",
            .product(name: "RxRelay", package: "RxSwift"),
        ]),
        .testTarget(name: "RxPropertyTests", dependencies: ["RxProperty"]),
    ]
)
