import Foundation
import CoreData

protocol DogsLocalDataSourceProtocol {
  func saveDogs(_ dogs: [Dog]) async throws
  func getDogs() async throws -> [Dog]
  func clearDogs() async throws
}

struct DogsLocalDataSource: DogsLocalDataSourceProtocol {
  private let managedContext: NSManagedObjectContext

  init(managedContext: NSManagedObjectContext) {
    self.managedContext = managedContext
  }

  func saveDogs(_ dogs: [Dog]) async throws {
    try await managedContext.perform {
      try clearDogsSync()

      for dog in dogs {
        let entity = DogEntity(context: managedContext)
        entity.name = dog.name
        entity.dogDescription = dog.description
        entity.age = Int16(dog.age)
        entity.imageUrl = dog.imageUrl
      }

      try saveContextIfNeeded()
    }
  }

  func getDogs() async throws -> [Dog] {
    try await managedContext.perform {
      let request: NSFetchRequest<DogEntity> = DogEntity.fetchRequest()
      let result = try managedContext.fetch(request)

      return result.map {
        Dog(
          name: $0.name ?? .empty,
          description: $0.dogDescription ?? .empty,
          age: Int($0.age),
          imageUrl: $0.imageUrl ?? .empty
        )
      }
    }
  }

  func clearDogs() async throws {
    try await managedContext.perform {
      try clearDogsSync()
    }
  }

  private func clearDogsSync() throws {
    let request: NSFetchRequest<NSFetchRequestResult> = DogEntity.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    try managedContext.execute(deleteRequest)
  }

  private func saveContextIfNeeded() throws {
    if managedContext.hasChanges {
      try managedContext.save()
    }
  }
}
