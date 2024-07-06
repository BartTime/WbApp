import SwiftUI

// MARK: Раскомнетить для базового перехода и удалить метод
//struct ContactsView: View {
//    @State private var searchText = ""
//    @Environment(\.colorScheme) var colorScheme
//
//
//    var filteredContacts: [Contact] {
//        filterContacts(contacts, by: searchText)
//    }
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                VStack(spacing: 0) {
//                    Spacer().frame(height: ConstantsSize.headerSpacerHeight)
//
//                    SearchBarView(searchText: $searchText)
//
//                    ContactListView(contacts: filteredContacts)
//                }
//                .customNavBar(
//                    title: "Контакты",
//                    rightButtonImages: ["plus"],
//                    rightButtonActions: [{ print("plus tapped") }]
//                )
//
//                .background(Color(ConstantsColor.backgroundColor))
//            }
//        }
//    }
//
//    private func filterContacts(_ contacts: [Contact], by searchText: String) -> [Contact] {
//        if searchText.isEmpty {
//            return contacts
//        } else {
//            return contacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
//}

struct ContactsViewAnimate: View {
    @State private var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedContact: Contact?
    @State private var showDetail = false
    
    var filteredContacts: [Contact] {
        filterContacts(contacts, by: searchText)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if showDetail, let selectedContact = selectedContact {
                    ProfileView(contact: selectedContact, showDetail: $showDetail)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)) .combined(with: .scale(scale: 0.2)))
                } else {
                    VStack(spacing: 0, content: {
                        Spacer().frame(height: ConstantsSize.headerSpacerHeight)
                        
                        SearchBarView(searchText: $searchText)
                        
                        ContactListView(contacts: filteredContacts, selectedContact: $selectedContact, showDetail: $showDetail)
                    })
                    .background(Color(ConstantsColor.backgroundColor))
                    .customNavBar(
                        title: "Контакты",
                        rightButtonImages: [("plus", false)],
                        rightButtonActions: [{ print("plus tapped") }]
                    )
                }
            }
            .animation(.easeInOut, value: showDetail)
        }
        .hideKeyboardOnTap()
    }
    
    private func filterContacts(_ contacts: [Contact], by searchText: String) -> [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

private struct ConstantsSize {
    static let headerSpacerHeight: CGFloat = 16
}

private struct ConstantsColor {
    static let backgroundColor = "BackgroundColor"
}

#Preview {
    // MARK: Раскомнетить для базового перехода и удалить метод
//    ContactsView()
    ContactsViewAnimate()
}
