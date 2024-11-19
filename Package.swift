// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "JSONSugar",
    platforms: [.iOS(.v17), .macOS(.v14)],
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
