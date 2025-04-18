// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SimpleToast",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v16)
    ],
    products: [
        .library(
            name: "SimpleToast",
            targets: ["SimpleToast"]),
    ],
    dependencies: [],
    targets: [        
        .target(name: "SimpleToast",dependencies: []),
        .testTarget(
            name: "SimpleToastTests",
            dependencies: ["SimpleToast"]),
    ]
)
