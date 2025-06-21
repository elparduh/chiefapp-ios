import Foundation

@MainActor
final class DogsViewModel: ObservableObject {
  @Published var dogs: [Dog] = []
  @Published var isLoading = false
  @Published var errorMessage: String?

  private let getDogsUseCase: GetDogsUseCaseProtocol

  init(getDogsUseCase: GetDogsUseCaseProtocol) {
    self.getDogsUseCase = getDogsUseCase
  }

  func loadDogs() async {
    isLoading = true
    defer { isLoading = false }

    let result = await getDogsUseCase.fetchDogs()

    switch result {
    case .success(let dogs):
      self.dogs = dogs
      self.errorMessage = nil
    case .failure(let error):
      self.errorMessage = error.localizedDescription
    }
  }
}
