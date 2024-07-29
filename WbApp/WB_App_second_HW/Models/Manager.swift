import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ContactsModel")
        
        if let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Alex.WbApp")?.appendingPathComponent("ContactsModel.sqlite") {
            let storeDescription = NSPersistentStoreDescription(url: storeURL)
            container.persistentStoreDescriptions = [storeDescription]
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error while saving context: \(nserror), \(nserror.userInfo)")
        }
    }
}

final class ContactManager: ObservableObject {
    static let shared = ContactManager()
    
    private init() {}

    private let context = CoreDataManager.shared.context
    
    func loadAllContacts() -> [Contacts] {
        return fetchContacts(fetchLimit: nil)
    }
    
    // Загрузка первых четырех контактов
    func loadFirstFourContacts() -> [Contacts] {
        return fetchContacts(fetchLimit: 4)
    }
    
   
    func createContact(name: String, phoneNumber: String, isOnline: Bool, hasStory: Bool, lastSeen: String, avatar: String?, initials: String?) {
        let newContact = Contacts(context: context)
        newContact.id = UUID()
        newContact.name = name
        newContact.phoneNumber = phoneNumber
        newContact.isOnline = isOnline
        newContact.hasStory = hasStory
        newContact.lastSeen = lastSeen
        newContact.avatar = avatar
        newContact.initials = initials
        
        saveContextWithMessage("Contact saved successfully.")
    }
    
    
    func updateContact(by id: UUID, name: String?, phoneNumber: String?, isOnline: Bool?, hasStory: Bool?, lastSeen: String?) {
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let contact = try context.fetch(fetchRequest).first {
                if let name = name { contact.name = name }
                if let phoneNumber = phoneNumber { contact.phoneNumber = phoneNumber }
                if let isOnline = isOnline { contact.isOnline = isOnline }
                if let hasStory = hasStory { contact.hasStory = hasStory }
                if let lastSeen = lastSeen { contact.lastSeen = lastSeen }
                
                saveContextWithMessage("Contact updated successfully.")
            } else {
                print("Contact with id \(id) not found.")
            }
        } catch {
            print("Failed to update contact: \(error)")
        }
    }
    
    
    func deleteAllContacts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Contacts.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            context.reset()
            print("All contacts deleted successfully.")
        } catch {
            print("Failed to delete all contacts: \(error)")
        }
    }

    private func fetchContacts(fetchLimit: Int?) -> [Contacts] {
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        if let fetchLimit = fetchLimit {
            fetchRequest.fetchLimit = fetchLimit
        }
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching contacts: \(error)")
            return []
        }
    }
    
    private func saveContextWithMessage(_ message: String) {
        do {
            try context.save()
            print(message)
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

