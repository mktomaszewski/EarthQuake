import Foundation
import CoreLocation

enum MagnitudeClass: Equatable {
    case normal
    case strong
}

struct EarthquakeItem {
    let identifier: String
    let location: CLLocationCoordinate2D
    let radiusInMeters: Double
    let magnitude: String
    let magnitudeClass: MagnitudeClass

    init(earthQuake: Earthquake) {
        self.identifier = earthQuake.eqid
        self.location = CLLocationCoordinate2D(
            latitude: earthQuake.lat,
            longitude: earthQuake.lng
        )

        self.radiusInMeters = earthQuake.depth * 1000
        self.magnitude = String(earthQuake.magnitude)
        self.magnitudeClass = earthQuake.magnitude >= 8 ? .strong : .normal
    }
}
