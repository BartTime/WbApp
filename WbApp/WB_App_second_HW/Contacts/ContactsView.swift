import SwiftUI

struct ContactsView: View {
    @State private var searchText = ""
    
    @EnvironmentObject var appData: AppData
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Contacts.name, ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<Contacts>
    
    let contactManager = ContactManager.shared
    
    var filteredContacts: [Contacts] {
        if searchText.isEmpty {
            return Array(contacts)
        } else {
            return contacts.filter { contact in
                contact.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $appData.contactsNavStack) {
            ZStack {
                VStack(spacing: 0) {
                    Spacer().frame(height: ConstantsSize.headerSpacerHeight)
                    
                    SearchBarView(searchText: $searchText)
                    
                    ContactListView(contacts: filteredContacts)
                        .environmentObject(appData)
                }
                
                
                .background(Color(ConstantsColor.backgroundColor))
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                   Text("Контакты")
                        .modifier(Subheading1())
                        .foregroundColor(.primary)
                        .padding(ConstantsSize.paddingSize)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: createContactsMock) {
                        Image("plus")
                            .resizable()
                            .modifier(RightIconsStyleNav())
                    }
                }
            })
            .navigationDestination(for: Contacts.self) { contact in
                ProfileView(contact: contact)
                    .environmentObject(appData)
            }
        }
    }
    
    private func deleteAllContacts() {
        contactManager.deleteAllContacts()
    }
    
    private func createContactsMock() {
        contactManager.createContact(name: "Анастасия Иванова", phoneNumber: "+7 999 999-99-99", isOnline: false, hasStory: false, lastSeen: "Last seen yesterday", avatar: "anastasia", initials: nil)
        contactManager.createContact(name: "Петя", phoneNumber: "+7 999 999-99-99", isOnline: true, hasStory: false, lastSeen: "Online", avatar: "anastasia", initials: nil)
        contactManager.createContact(name: "Маман", phoneNumber: "+7 999 999-99-99", isOnline: false, hasStory: true, lastSeen: "Last seen 3 hours ago", avatar: "maman", initials: nil)
        contactManager.createContact(name: "Арбуз Дыня", phoneNumber: "+7 999 999-99-99", isOnline: true, hasStory: false, lastSeen: "Online", avatar: "anastasia", initials: nil)
        contactManager.createContact(name: "Иван Иванов", phoneNumber: "+7 999 999-99-99", isOnline: true, hasStory: false, lastSeen: "Online", avatar: nil, initials: "ИИ")
        contactManager.createContact(name: "Лиса Алиса", phoneNumber: "+7 999 999-99-99", isOnline: false, hasStory: true, lastSeen: "Last seen 30 minutes ago", avatar: nil, initials: "ЛА")
        contactManager.createContact(name: "Арбуз Дыня", phoneNumber: "+7 999 999-99-99", isOnline: true, hasStory: false, lastSeen: "Online", avatar: "anastasia", initials: nil)
        contactManager.createContact(name: "Иван Иванов", phoneNumber: "+7 999 999-99-99", isOnline: true, hasStory: false, lastSeen: "Online", avatar: nil, initials: "ИИ")
    }
}

private struct ConstantsSize {
    static let headerSpacerHeight: CGFloat = 16
    static let paddingSize: CGFloat = 8
}

private struct ConstantsColor {
    static let backgroundColor = "BackgroundColor"
}

#Preview {
    ContactsView()
}
