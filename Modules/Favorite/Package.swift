// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorite",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Favorite",
            targets: ["Favorite"]
        )
    ],
    dependencies: [
        // Align with Core
        .package(
            url: "https://github.com/realm/realm-swift.git",
            .upToNextMajor(from: "10.50.0")
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.2.0")
        ),
        .package(path: "../Core"),
        .package(path: "../Games"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Favorite",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                "Core",
                "Games",
                "Alamofire",
            ]
        ),
        .testTarget(
            name: "FavoriteTests",
            dependencies: ["Favorite"]
        ),
    ]
)
