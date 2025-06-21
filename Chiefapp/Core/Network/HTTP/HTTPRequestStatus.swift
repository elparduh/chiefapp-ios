import Foundation

enum HTTPRequestStatus: Error {
  case success
  case badRequest
  case unauthorized
  case forbidden
  case internalServerError
  case notFound
  case connectionIssue
  case unknown(String)
  case invalidURL
  case decodingError
}
