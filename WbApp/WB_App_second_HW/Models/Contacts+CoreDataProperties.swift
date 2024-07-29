import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var hasStory: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var initials: String?
    @NSManaged public var isOnline: Bool
    @NSManaged public var lastSeen: String?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var imageUrl: String?
}

extension Contacts : Identifiable {

}
