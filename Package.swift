// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "JSONSugar",
    platforms: [.iOS(.v15), .macOS(.v10_15)],
    products: [
        .library(
            name: "JSONSugar",
            targets: ["JSONSugar"])
    ],
    dependencies: [
      .package(url: "https://github.com/eonist/FileSugar.git", branch: "master")
    ],
    targets: [
        .target(
            name: "JSONSugar",
            dependencies: ["FileSugar"]),
        .testTarget(
            name: "JSONSugarTests",
            dependencies: ["JSONSugar"])
    ]
)
