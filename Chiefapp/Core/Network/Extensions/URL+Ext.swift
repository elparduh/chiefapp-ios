import Foundation

extension URL {

  func createURLRequest(method: HTTPMethod, headers: [String: String]? = nil) -> URLRequest {
    var request = URLRequest(url: self)
    request.httpMethod = method.rawValue
    request.timeoutInterval = 3
    headers?.forEach { key, value in
      request.setValue(value, forHTTPHeaderField: key)
    }
    return request
  }
}
