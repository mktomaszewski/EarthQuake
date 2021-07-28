import Foundation

struct EarthQuake: Decodable {
    let eqid: String
    let datetime: String
    let depth: Double
    let lat: Double
    let lng: Double
    let magnitude: Double
}

struct EarthQuakeResponse: Decodable {
    let earthquakes: [EarthQuake]
}
