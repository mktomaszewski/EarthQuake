import Foundation

enum NetworkError: Error, Equatable {
    case unknown
    case invalidURL
    case invalidRequest
    case invalidResponse
    case error(data: Data, statusCode: Int)
}

protocol NetworkClientProtocol: AnyObject {
    @discardableResult
    func perform(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask?
}

enum NetworkClientURL {
    static let baseUrl = URL(string: Bundle.main.infoDictionary!["API_URL"] as! String)!
}

final class NetworkClient: NetworkClientProtocol {
    private let baseURL: URL
    private let urlSession: URLSession

    init(baseURL: URL = NetworkClientURL.baseUrl, urlSession: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    func perform(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask? {
        do {
            let basedRequest =  try request.requestWithURLRelative(to: baseURL)
            let task = urlSession.dataTask(with: basedRequest) { data, response, error in
                completion(NetworkClient.validateResponse((data, response)))
            }
            task.resume()
            return task
        } catch {
            completion(.failure(.invalidRequest))
            return nil
        }
    }

    static func validateResponse(_ dataAndResponse: (Data?, URLResponse?)) -> Result<Data, NetworkError> {
        let (data, response) = dataAndResponse
        guard let data = data,
              let httpResponse = response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }

        guard 200..<400 ~= httpResponse.statusCode else {
            return .failure(NetworkError.error(data: data, statusCode: httpResponse.statusCode))
        }
        return .success(data)
    }
}
