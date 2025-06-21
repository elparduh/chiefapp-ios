import Foundation

extension APIClientProtocol {

  func get<T: Decodable>(
    path: String,
    queryItems: [URLQueryItem]? = nil,
    headers: [String: String]? = nil
  ) async throws -> T {
    try await get(path: path, queryItems: queryItems, headers: headers)
  }
}

