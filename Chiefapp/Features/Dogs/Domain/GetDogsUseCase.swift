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
    await dogsRepositoryProtocol.fetchDogs()
  }
}
