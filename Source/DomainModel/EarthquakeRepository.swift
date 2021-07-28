import Foundation

protocol EarthquakeRepositoryProtocol {
    func getEarthquakeItems(completion: @escaping (Result<[EarthquakeItem], NetworkError>) -> Void)
}

final class EarthquakeRepository: EarthquakeRepositoryProtocol {
    private let apiClient: EarthquakeApiClientProtocol

    init(apiClient: EarthquakeApiClientProtocol) {
       self.apiClient = apiClient
   }

    func getEarthquakeItems(completion: @escaping (Result<[EarthquakeItem], NetworkError>) -> Void) {
        apiClient.getEarthquakes(north: 44.1, south: 9.9, east: -22.4, west: 55.2) { result in
            switch result {
            case .success(let earthquake):
                let items = earthquake.earthquakes.map(EarthquakeItem.init)
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
