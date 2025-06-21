import Foundation

protocol GetDogsUseCaseProtocol {
  func fetchDogs() async -> Result<[Dog], Error>
}

struct GetDogsUseCase: GetDogsUseCaseProtocol {
  private let dogsRepositoryProtocol: DogsRepositoryProtocol

  init(dogsRepositoryProtocol: DogsRepositoryProtocol) {
    self.dogsRepositoryProtocol = dogsRepositoryProtocol
  }

  func fetchDogs() async -> Result<[Dog], Error> {
    do {
      let dogs = try await dogsRepositoryProtocol.fetchDogs()
      return .success(dogs)
    } catch {
      return .failure(error)
    }
  }
}
