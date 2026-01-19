// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "LocationSearch",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        // Wat je "exporteert" naar de buitenwereld
        // Andere projecten die jouw package importeren krijgen toegang tot deze library
        .library(
            name: "LocationSearch",
            targets: ["LocationSearch"]
        ),
    ],
    dependencies: [
        // PointFree's dependency injection library
        // Maakt het mogelijk om dependencies te "swappen" voor tests en previews
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            from: "1.6.0"
        ),
    ],
    targets: [
        // De hoofdtarget met alle broncode
        .target(
            name: "LocationSearch",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ]
        ),
        // Tests - hier kunnen we straks de mock dependencies gebruiken
        .testTarget(
            name: "LocationSearchTests",
            dependencies: ["LocationSearch"]
        ),
    ]
)
