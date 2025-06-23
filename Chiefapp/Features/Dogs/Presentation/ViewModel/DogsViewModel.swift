import Foundation

@MainActor
final class DogsViewModel: ObservableObject {
  @Published var uiState: UIState<[DogUi]> = .initial

  private let getDogsUseCase: GetDogsUseCaseProtocol

  init(getDogsUseCase: GetDogsUseCaseProtocol) {
    self.getDogsUseCase = getDogsUseCase
  }

  func loadDogs() async {
    uiState = .loading

    let result = await getDogsUseCase.fetchDogs()
    switch result {
    case .success(let dogs):
      uiState = .success(dogs.toDogUiList())
    case .failure(let error):
      uiState = .failure(error.localizedDescription)
    }
  }
}
