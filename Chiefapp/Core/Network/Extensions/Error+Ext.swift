import Foundation

extension Error {

  func isNetworkConnectionError() -> Bool {
    let networkErrors = [
      NSURLErrorNetworkConnectionLost,
      NSURLErrorNotConnectedToInternet,
      NSURLErrorTimedOut
    ]
    let nsError = self as NSError
    return networkErrors.contains(nsError.code)
  }
}
