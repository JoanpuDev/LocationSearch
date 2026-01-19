import Dependencies
import DependenciesMacros
import MapKit

@DependencyClient public struct LocationClient: Sendable {
    public var search: @Sendable (_ query: String) async throws -> [LocalSearchResult]
}

extension LocationClient {
    static let live = LocationClient { query in
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        
        return response.mapItems.map(LocalSearchResult.init)
    }
}

extension LocationClient {
    static let preview = LocationClient { query in
        
        try await Task.sleep(for: .milliseconds(300))
        
        guard !query.isEmpty else { return mockLocations }
        
        return mockLocations.filter { $0.name.localizedStandardContains(query) || $0.address.localizedStandardContains(query) }
    }
    
    private static let mockLocations: [LocalSearchResult] = [
        LocalSearchResult(name: "Grand Frais", address: "Avenue de Cannes, 06250 Mougins", coordinate: Coordinate(latitude: 43.5950, longitude: 6.9950)),
        LocalSearchResult(name: "Musée de la Photographie", address: "Porte Sarrazine, 06250 Mougins", coordinate: Coordinate(latitude: 43.5989, longitude: 6.9928)),
        LocalSearchResult(name: "Le Mas Candille", address: "Boulevard Clément Rebuffel, 06250 Mougins", coordinate: Coordinate(latitude: 43.5920, longitude: 6.9975)),
        LocalSearchResult(name: "Mougins School", address: "615 Avenue Maurice Donat, 06250 Mougins", coordinate: Coordinate(latitude: 43.5893, longitude: 7.0019))
    ]
}

extension LocationClient: DependencyKey {
    public static let liveValue: LocationClient = .live
    public static let previewValue: LocationClient = .preview
}

extension DependencyValues {
    public var locationClient: LocationClient {
        get { self[LocationClient.self] }
        set { self[LocationClient.self] = newValue }
    }
}
