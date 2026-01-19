# LocationSearch

A lightweight Swift package for location search using MapKit, built with [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies) pattern.

## Features

- Simple `LocationClient` for location searches
- Fully `Sendable` compliant for Swift 6 strict concurrency
- Built-in preview implementation for SwiftUI previews
- Wraps MapKit types in clean, encapsulated models

## Installation

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/JoanpuDev/LocationSearch.git", from: "1.0.0")
]
```

Or in Xcode: File → Add Package Dependencies → paste the URL.

## Usage

### Basic search

```swift
import LocationSearch
import Dependencies

struct MyView: View {
    @Dependency(\.locationClient) var locationClient

    func search() async throws {
        let results = try await locationClient.search("Amsterdam")
        // results: [LocalSearchResult]
    }
}
```

### In SwiftUI Previews

The package automatically uses mock data in previews - no configuration needed.

```swift
#Preview {
    MyView()
}
```

### Override in tests

```swift
import Dependencies

@Test func myTest() async throws {
    await withDependencies {
        $0.locationClient.search = { _ in
            [LocalSearchResult(name: "Mock", address: "Test", coordinate: .init(latitude: 0, longitude: 0))]
        }
    } operation: {
        // your test code
    }
}
```

## Requirements

- iOS 26+ / macOS 26+
- Swift 6.0+

## License

MIT License. See [LICENSE](LICENSE) for details.
