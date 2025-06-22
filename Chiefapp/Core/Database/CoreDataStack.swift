import CoreData

final class CoreDataStack {
  static let shared = CoreDataStack()

  private init() {}

  var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ChiefModel")
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Core Data load error: \(error)")
      }
    }
    return container
  }()

  var context: NSManagedObjectContext {
    container.viewContext
  }
  
  func saveContext() {
    let context = container.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        print("Error saving context: \(error.localizedDescription)")
      }
    }
  }
}
