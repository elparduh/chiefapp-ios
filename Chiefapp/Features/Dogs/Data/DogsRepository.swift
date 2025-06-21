import Foundation

protocol DogsRepositoryProtocol {
  func fetchDogs() async throws -> [Dog]
}

struct DogsRepository: DogsRepositoryProtocol {
  private let dogsRemoteDataSourceProtocol: DogsRemoteDataSourceProtocol

  init(dogsRemoteDataSourceProtocol: DogsRemoteDataSourceProtocol) {
    self.dogsRemoteDataSourceProtocol = dogsRemoteDataSourceProtocol
  }
  
  func fetchDogs() async throws -> [Dog] {
    try await dogsRemoteDataSourceProtocol.fetchDogs().toDogList()
  }
}
