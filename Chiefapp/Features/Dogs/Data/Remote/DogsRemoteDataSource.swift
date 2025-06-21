import Foundation

protocol DogsRemoteDataSourceProtocol {
  var  apiClient: APIClientProtocol { get }
  func fetchDogs() async throws -> [DogApiResponse]
}

struct DogsRemoteDataSource: DogsRemoteDataSourceProtocol {
  var apiClient: APIClientProtocol
  
  init(apiClient: APIClientProtocol) {
    self.apiClient = apiClient
  }
  
  func fetchDogs() async throws -> [DogApiResponse] {
    let response: [DogApiResponse] = try await apiClient.get(path: APIConfig.Endpoint.allDogs)
    return response
  }
}
