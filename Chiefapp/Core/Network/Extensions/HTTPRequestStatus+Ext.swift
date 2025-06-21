import Foundation

extension HTTPRequestStatus {

  func getMessage() -> String {
    switch self {
    case .success: return "Success"
    case .badRequest: return "Bad request"
    case .unauthorized: return "User unauthorized"
    case .forbidden: return "Forbidden request"
    case .internalServerError: return "Something went wrong"
    case .notFound: return "URL not found"
    case .connectionIssue: return "No internet connection"
    case .unknown(let msg): return msg
    case .invalidURL: return "Invalid URL"
    case .decodingError: return "Decoding error"
    }
  }
  
  func hasErrors() -> Bool {
    if case .success = self {
      return false
    }
    return true
  }
}
