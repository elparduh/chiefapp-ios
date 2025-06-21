import Foundation

protocol DogsRepositoryProtocol {
  var dogsRemoteDataSourceProtocol: DogsRemoteDataSourceProtocol { get }
  func fetchDogs() async throws -> [DogApiResponse]
}

struct DogsRepository: DogsRepositoryProtocol {
  var dogsRemoteDataSourceProtocol: DogsRemoteDataSourceProtocol
  
  init(dogsRemoteDataSourceProtocol: DogsRemoteDataSourceProtocol) {
    self.dogsRemoteDataSourceProtocol = dogsRemoteDataSourceProtocol
  }
  
  func fetchDogs() async throws -> [DogApiResponse] {
    try await dogsRemoteDataSourceProtocol.fetchDogs()
  }
}
