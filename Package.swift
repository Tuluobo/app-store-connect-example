// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Example",
    products: [
        .library(name: "Example", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        // 🍃 An expressive, performant, and extensible templating language built for Swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0"),
        
        // .package(path: "../app-store-connect"),
        .package(url: "https://github.com/Tuluobo/app-store-connect.git", .branch("develop")),
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "ASCApi", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

