import Foundation

struct EarthQuake: Decodable {
    let datetime: Date
    let depth: Double
    let lat: Double
    let lng: Double
    let magnitude: Double
}

struct EarthQuakeResponse: Decodable {
    let earthquakes: EarthQuake
}
