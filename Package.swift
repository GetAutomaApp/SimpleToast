// swift-tools-version:5.7
import PackageDescription

// swiftlint:disable:next explicit_acl explicit_top_level_acl
let package = Package(
    name: "SimpleToast",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v16)
    ],
    products: [
        .library(
            name: "SimpleToast",
            targets: ["SimpleToast"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(name: "SimpleToast", dependencies: []),
        .testTarget(
            name: "SimpleToastTests",
            dependencies: ["SimpleToast"]
        ),
    ]
)
