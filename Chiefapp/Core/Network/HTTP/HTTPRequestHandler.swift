import Foundation

typealias APIResponse = (data: Data, httpResponse: URLResponse)

struct HttpRequestHandler {

  func createRequestStatus(response: APIResponse) -> HTTPRequestStatus {
    guard let httpResponse = response.httpResponse as? HTTPURLResponse else {
      return .unknown("Invalid response object")
    }

    switch httpResponse.statusCode {
    case 200: return .success
    case 400: return .badRequest
    case 401: return .unauthorized
    case 403: return .forbidden
    case 404: return .notFound
    case 500: return .internalServerError
    default:
      let message = String(data: response.data, encoding: .utf8) ?? "Unknown"
      return .unknown(message)
    }
  }

  func createRequestStatusFrom(error: Error) -> HTTPRequestStatus {
    if error.isNetworkConnectionError() {
      return HTTPRequestStatus.connectionIssue
    }
    return HTTPRequestStatus.unknown(error.localizedDescription)
  }
}
