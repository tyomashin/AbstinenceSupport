// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AbstinenceSupportPackage",
    defaultLocalization: "ja",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AbstinenceSupportCore",
            targets: ["AbstinenceSupportCore"]
        ),
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        ),
        .library(
            name: "Common",
            targets: ["Common"]
        ),
        .library(
            name: "Infrastructure",
            targets: ["Infrastructure"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.6.3"),
    ],
    targets: [
        
        // MARK: - Features
        
        .target(
            name: "AbstinenceSupportCore",
            dependencies: [
                "Presentation",
            ]
        ),
        .target(
            name: "Presentation",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "Common",
                "Interface",
            ]
        ),
        .target(
            name: "Common",
            dependencies: []
        ),
        .target(
            name: "Interface",
            dependencies: []
        ),
        .target(
            name: "Infrastructure",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "Interface",
            ]
        ),
        
        // MARK: - Tests
        
        .testTarget(
            name: "InfrastructureTests",
            dependencies: [
                "Infrastructure",
            ]
        ),
    ]
)
