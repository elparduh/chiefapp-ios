import Foundation

protocol DogsRemoteDataSourceProtocol {
  func fetchDogs() async throws -> [DogApiResponse]
}

struct DogsRemoteDataSource: DogsRemoteDataSourceProtocol {
  private let apiClient: APIClientProtocol

  init(apiClient: APIClientProtocol) {
    self.apiClient = apiClient
  }

  func fetchDogs() async throws -> [DogApiResponse] {
    try await apiClient.get(path: APIConfig.Endpoint.allDogs)
  }
}
