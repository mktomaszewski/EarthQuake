import Foundation

extension URLRequest {
    init(method: HTTPMethod,
         path: String,
         queryItems: [String: String] = [:],
         body: Data? = nil,
         headers: [String: String] = [:],
         contentType: String = "application/json") throws {

        guard let url = URL(string: path) else {
            throw NetworkError.invalidURL
        }

        var charSet = CharacterSet.urlQueryAllowed
        charSet.remove("+")
        charSet.insert("µ")

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if queryItems.count > 0 {
            components?.queryItems = queryItems.map(URLQueryItem.init)
        }
        let encodedQuery = components?.query?.addingPercentEncoding(withAllowedCharacters: charSet)
        components?.percentEncodedQuery = encodedQuery

        guard let fullURL = components?.url else {
            throw NetworkError.invalidURL
        }

        var req = URLRequest(url: fullURL)
        req.httpMethod = method.rawValue
        req.setValue(contentType, forHTTPHeaderField: "Content-Type")
        headers.forEach { pair in
            req.setValue(pair.value, forHTTPHeaderField: pair.key)
        }
        req.httpBody = body

        self = req
    }

    func requestWithURLRelative(to url: URL) throws -> URLRequest {
        guard let originalURL = self.url else {
            throw NetworkError.invalidURL
        }

        guard
            var comps = URLComponents(url: originalURL, resolvingAgainstBaseURL: true)
            else {
                throw NetworkError.invalidURL
        }

        guard
            let replacement = URLComponents(url: url, resolvingAgainstBaseURL: true)
            else {
                throw NetworkError.invalidURL
        }

        comps.scheme = replacement.scheme
        comps.host = replacement.host

        guard let newURL = comps.url else {
            throw NetworkError.invalidURL
        }

        var copy = self
        copy.url = newURL

        return copy
    }
}
