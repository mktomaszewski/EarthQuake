import Foundation

protocol EarthquakeDetailsViewModelProtocol {
    var earthquakeItem: EarthquakeItem { get }
}

final class EarthquakeDetailsViewModel: EarthquakeDetailsViewModelProtocol {
    let earthquakeItem: EarthquakeItem

    init(earthquakeItem: EarthquakeItem) {
        self.earthquakeItem = earthquakeItem
    }
}
