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
    @StateObject private var imageLoader = ImageLoader()

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
                        .environmentObject(imageLoader)
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
           let contactNames = [
               "Анастасия Иванова",
               "Петя",
               "Маман",
               "Арбуз Дыня",
               "Иван Иванов",
               "Лиса Алиса"
           ]

           Task {
               for name in contactNames {
                   if let url = await fetchRandomImageURL() {
                       contactManager.createContact(
                           name: name,
                           phoneNumber: "+7 999 999-99-99",
                           isOnline: Bool.random(),
                           hasStory: Bool.random(),
                           lastSeen: Bool.random() ? "Online" : "Last seen \(Int.random(in: 1...24)) hours ago",
                           avatar: "anastasia",
                           initials: nil,
                           imageUrl: url
                       )
                   }
               }
           }
       }
    
    private func fetchRandomImageURL() async -> String? {
            guard let url = URL(string: "https://random.dog/woof.json") else { return nil }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let dogImageResponse = try JSONDecoder().decode(DogImageResponse.self, from: data)
                return dogImageResponse.url
            } catch {
                print("Failed to fetch image URL: \(error.localizedDescription)")
                return nil
            }
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
