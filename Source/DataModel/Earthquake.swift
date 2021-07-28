import Foundation

struct Earthquake: Decodable {
    let eqid: String
    let datetime: String
    let depth: Double
    let lat: Double
    let lng: Double
    let magnitude: Double
}

struct EarthquakeResponse: Decodable {
    let earthquakes: [Earthquake]
}
