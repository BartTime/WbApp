import Foundation
import CoreData

class AppData: ObservableObject {
    @Published var activeTab: Tabs = .contacts
    @Published var contactsNavStack: [Contacts] = []
    @Published var chatsNavStack: [String] = []
    @Published var moreNavStack: [String] = []
    
    private let coreDataManager = CoreDataManager.shared
    
    static let shared: AppData = .init()
    private init() {}
    
    func loadAllContacts() -> [Contacts] {
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        do {
            return try coreDataManager.context.fetch(fetchRequest)
        } catch {
            print("Error fetching contacts: \(error)")
            return []
        }
    }
    
    func removeContactFromNavStack(contact: Contacts) {
        contactsNavStack.removeAll { $0 == contact }
    }
    
    func handleDeepLink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        
        if let tabRawValue = components.queryItems?.first(where: { $0.name == "tab" })?.value,
           let requestedTab = Tabs.convert(from: tabRawValue) {
            DispatchQueue.main.async {
                self.activeTab = requestedTab
            }
        }
        
        if let contactIDString = components.queryItems?.first(where: { $0.name == "id" })?.value,
           let contactID = UUID(uuidString: contactIDString) {
            fetchContactByID(contactID: contactID) { contact in
                if let contact = contact {
                    DispatchQueue.main.async {
                        self.contactsNavStack.append(contact)
                    }
                }
            }
        }
    }
    
    private func fetchContactByID(contactID: UUID, completion: @escaping (Contacts?) -> Void) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", contactID as CVarArg)
        
        context.perform {
            do {
                let results = try fetchRequest.execute()
                completion(results.first)
            } catch {
                print("Failed to fetch contact: \(error)")
                completion(nil)
            }
        }
    }
}
