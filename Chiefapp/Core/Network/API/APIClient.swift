import Foundation

protocol APIClientProtocol {
  func get<T: Decodable>(
    path: String,
    queryItems: [URLQueryItem]?,
    headers: [String: String]?
  ) async throws -> T
}

struct APIClient: APIClientProtocol {
  private let session: URLSession
  private let requestHandler: HttpRequestHandler
  private let baseUrl: String

  init(session: URLSession,
       requestHandler: HttpRequestHandler,
       baseUrl: String) {
    self.session = session
    self.requestHandler = requestHandler
    self.baseUrl = baseUrl
  }

  func get<T: Decodable>(
    path: String,
    queryItems: [URLQueryItem]? = nil,
    headers: [String: String]? = nil
  ) async throws -> T {
    guard var urlComponents = URLComponents(string: baseUrl + path) else {
      throw HTTPRequestStatus.invalidURL
    }

    urlComponents.queryItems = queryItems

    guard let url = urlComponents.url else {
      throw HTTPRequestStatus.invalidURL
    }

    let request = url.createURLRequest(method: .get, headers: headers)

    do {
      let response: APIResponse = try await session.data(for: request)
      let status = requestHandler.createRequestStatus(response: response)

      if status.hasErrors() {
        throw status
      }

      guard let decoded = try? JSONDecoder().decode(T.self, from: response.data) else {
        throw HTTPRequestStatus.decodingError
      }

      return decoded
    } catch {
      throw requestHandler.createRequestStatusFrom(error: error)
    }
  }
}
