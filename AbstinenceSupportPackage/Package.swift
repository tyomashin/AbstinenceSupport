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
        .library(
            name: "Domain",
            targets: ["Domain"]
        ),
        .library(
            name: "Entity",
            targets: ["Entity"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.6.3"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.5.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.7.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "12.0.0"),
    ],
    targets: [
        
        // MARK: - Features
        
        .target(
            name: "AbstinenceSupportCore",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
                "Common",
                "Presentation",
                "Domain",
                "Entity",
                "Infrastructure",
            ]
        ),
        .target(
            name: "Presentation",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
                "Common",
                "Interface",
                "Domain",
                "Entity",
            ]
        ),
        .target(
            name: "Common",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios"),
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "Interface",
            dependencies: [
                "Entity"
            ]
        ),
        .target(
            name: "Infrastructure",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "Interface",
            ]
        ),
        .target(
            name: "Domain",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "Interface",
                "Entity",
                "Infrastructure",
                "Common",
            ]
        ),
        .target(
            name: "Entity",
            dependencies: [
                "Common",
            ]
        ),
        .target(
            name: "TestHelper",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "Interface",
                "Entity",
                "Infrastructure",
                "Domain",
            ]
        ),
        
        // MARK: - Tests
        
        .testTarget(
            name: "InfrastructureTests",
            dependencies: [
                "Infrastructure",
                "TestHelper",
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "Domain",
                "TestHelper",
            ]
        ),
        .testTarget(
            name: "EntityTests",
            dependencies: [
                "Entity",
                "Common",
            ]
        ),
    ]
)
