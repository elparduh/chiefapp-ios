import Foundation
import SwiftUI

enum ChiefInjector {

  private static func provideAPIClient() -> APIClientProtocol {
    APIClient(
      session: URLSession.shared,
      requestHandler: HttpRequestHandler(),
      baseUrl: APIConfig.baseUrl
    )
  }

  private static func provideDogsRemoteDataSource() -> DogsRemoteDataSourceProtocol {
    DogsRemoteDataSource(apiClient: provideAPIClient())
  }

  private static func provideDogsRepository() -> DogsRepositoryProtocol {
    DogsRepository(dogsRemoteDataSourceProtocol: provideDogsRemoteDataSource())
  }

  private static func provideGetDogsUseCase() -> GetDogsUseCaseProtocol {
    GetDogsUseCase(dogsRepositoryProtocol: provideDogsRepository())
  }

  @MainActor
  private static func provideDogsViewModel() -> DogsViewModel {
    DogsViewModel(getDogsUseCase: provideGetDogsUseCase())
  }

  @MainActor
  static func provideHomeView() -> some View {
    HomeView(viewModel: provideDogsViewModel())
  }
}
