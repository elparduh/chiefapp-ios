import Foundation
import CoreData
import SwiftUI

enum ChiefInjector {
  private static func provideCoreDataContext() -> NSManagedObjectContext {
    CoreDataStack.shared.context
  }

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

  private static func provideDogsLocalDataSource() -> DogsLocalDataSourceProtocol {
    DogsLocalDataSource(managedContext: provideCoreDataContext())
  }

  private static func provideDogsRepository() -> DogsRepositoryProtocol {
    DogsRepository(
      dogsRemoteDataSourceProtocol: provideDogsRemoteDataSource(),
      dogsLocalDataSourceProtocol: provideDogsLocalDataSource()
    )
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
