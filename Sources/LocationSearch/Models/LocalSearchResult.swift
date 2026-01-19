import MapKit

/// Een zoekresultaat van de locatiezoeker.
///
/// Dit is ons eigen model - we wrappen `MKMapItem` in plaats van het direct te exposeren.
/// Waarom? Encapsulation. Als Apple's API verandert, hoeven consumers van onze module
/// hun code niet aan te passen. Wij passen alleen de mapping aan.
public struct LocalSearchResult: Sendable, Identifiable, Equatable {
    public let id: UUID
    public let name: String
    public let address: String
    public let coordinate: Coordinate

    public init(
        id: UUID = UUID(),
        name: String,
        address: String,
        coordinate: Coordinate
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.coordinate = coordinate
    }
}

// MARK: - Coordinate

/// Een simpele coordinate struct die `Sendable` is.
///
/// `CLLocationCoordinate2D` is niet `Sendable` in strict concurrency mode.
/// Door onze eigen struct te maken, kunnen we veilig data tussen actors sturen.
public struct Coordinate: Sendable, Equatable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: - Mapping van MKMapItem

extension LocalSearchResult {
    /// Maakt een `LocalSearchResult` van een `MKMapItem`.
    ///
    /// Dit is de enige plek waar we met MapKit's types werken.
    /// De rest van de codebase werkt met onze eigen types.
    ///
    /// Let op: In iOS 26+ is `MKPlacemark` deprecated. We gebruiken nu:
    /// - `mapItem.location` voor coordinaten
    /// - `mapItem.addressRepresentations` voor geformatteerde strings
    init(mapItem: MKMapItem) {
        self.id = UUID()
        self.name = mapItem.name ?? "Onbekende locatie"

        self.address = mapItem.addressRepresentations?.fullAddress(includingRegion: true, singleLine: true) ?? ""

        self.coordinate = Coordinate(
            latitude: mapItem.location.coordinate.latitude,
            longitude: mapItem.location.coordinate.longitude
        )
    }
}
