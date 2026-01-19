import Foundation
import Testing
@testable import LocationSearch

@Test func localSearchResultIsEquatable() async throws {
    let id = UUID()
    let a = LocalSearchResult(id: id, name: "Test", address: "addr", coordinate: Coordinate(latitude: 0.1, longitude: 0.1))
    let b = LocalSearchResult(id: id, name: "Test", address: "addr", coordinate: Coordinate(latitude: 0.1, longitude: 0.1))
    #expect(a == b)
}

@Test func localSearchResultWithDifferentIDsAreNotEquakl() async throws {
    let a = LocalSearchResult(name: "Test", address: "addr", coordinate: Coordinate(latitude: 0.1, longitude: 0.1))
    let b = LocalSearchResult(name: "Test", address: "addr", coordinate: Coordinate(latitude: 0.1, longitude: 0.1))
    #expect(a != b)
}

@Test func previewClientWithEmptyQueryReturnsAll() async throws {
    let results = try await LocationClient.preview.search(query: "")
    #expect(results.count == 4)
}

@Test func previewClientFiltersOnName() async throws {
    let results = try await LocationClient.preview.search(query: "Musée")
    #expect(results.count == 1)
    #expect(results.first?.name == "Musée de la Photographie")
}

@Test func previewClientNoMatchReturnsEmpty() async throws {
    let results = try await LocationClient.preview.search(query: "This is a test query with no matching results")
    #expect(results.isEmpty)
}

@Test func previewClientFiltersOnAddress() async throws {
    let results = try await LocationClient.preview.search(query: "Mougins")
    #expect(results.count == 4)
}
