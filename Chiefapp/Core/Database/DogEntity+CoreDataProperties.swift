import Foundation
import CoreData


extension DogEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogEntity> {
        return NSFetchRequest<DogEntity>(entityName: "DogEntity")
    }

    @NSManaged public var age: Int16
    @NSManaged public var dogDescription: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?

}

extension DogEntity : Identifiable {

}
