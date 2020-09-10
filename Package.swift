// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "JSONSugar",
    products: [
        .library(
            name: "JSONSugar",
            targets: ["JSONSugar"])
    ],
    dependencies: [
        .package(url: "https://github.com/eonist/FileSugar.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "JSONSugar",
            dependencies: ["FileSugar"])
    ]
)
