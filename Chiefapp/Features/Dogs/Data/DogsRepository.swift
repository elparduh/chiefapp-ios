import Foundation

protocol DogsRepositoryProtocol {
  func fetchDogs() async -> Result<[Dog], Error>
}

struct DogsRepository: DogsRepositoryProtocol {
  private let dogsRemoteDataSourceProtocol: DogsRemoteDataSourceProtocol
  private let dogslocalDataSourceProtocol: DogsLocalDataSourceProtocol
  
  init(
    dogsRemoteDataSourceProtocol: DogsRemoteDataSourceProtocol,
    dogsLocalDataSourceProtocol: DogsLocalDataSourceProtocol
  ) {
    self.dogsRemoteDataSourceProtocol = dogsRemoteDataSourceProtocol
    self.dogslocalDataSourceProtocol = dogsLocalDataSourceProtocol
  }
  
  func fetchDogs() async throws -> [Dog] {
    try await dogsRemoteDataSourceProtocol.fetchDogs().toDogList()
  }
  
  func fetchDogs() async -> Result<[Dog], any Error> {
    do {
      let remoteDogs = try await dogsRemoteDataSourceProtocol.fetchDogs().toDogList()
      try await dogslocalDataSourceProtocol.saveDogs(remoteDogs)
      return .success(remoteDogs)
    } catch {
      do {
        let localDogs = try await dogslocalDataSourceProtocol.fetchDogs()
        return .success(localDogs)
      } catch {
        return .failure(error)
      }
    }
  }
}
