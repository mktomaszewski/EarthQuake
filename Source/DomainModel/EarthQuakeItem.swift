import Foundation
import CoreLocation

enum Strength: Equatable {
    case normal
    case strong
}

struct EarthQuakeItem {
    let location: CLLocationCoordinate2D
    let radius: Double
    let strength: Strength

    init(earthQuake: EarthQuake) {
        self.location = CLLocationCoordinate2D(
            latitude: earthQuake.lat,
            longitude: earthQuake.lng
        )

        self.radius = earthQuake.depth
        self.strength = earthQuake.magnitude >= 8 ? .strong : .normal
    }
}
