import Foundation

protocol EarthquakeApiClientProtocol: AnyObject {
    func getEarthquakes(north: Double, south: Double, east: Double, west: Double, completion: @escaping (Result<EarthquakeResponse, NetworkError>) -> Void)
}

final class EarthquakeApiClient: EarthquakeApiClientProtocol {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func getEarthquakes(north: Double, south: Double, east: Double, west: Double, completion: @escaping (Result<EarthquakeResponse, NetworkError>) -> Void) {

        let request: URLRequest
        do {
            request = try URLRequest(
                method: HTTPMethod.get,
                path: "/earthquakesJSON",
                queryItems: [
                "north": String(north),
                "south": String(south),
                "east": String(east),
                "west": String(west),
                "username": "mkoppelman"
                ])
        } catch {
            completion(.failure(NetworkError.invalidRequest))
            return
        }

        networkClient.perform(
            request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(EarthquakeResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print(error)
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
