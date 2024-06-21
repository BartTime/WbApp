import SwiftUI

struct ContactListView: View {
    var contacts: [Contacts]
    
    var body: some View {
        List {
            ForEach(contacts) { contact in
                ContactRowView(contact: contact)
                    .listRowBackground(Color(ConstantsColor.backgroundColor))
                    .padding(.vertical, ConstantsSize.contactRowVerticalPadding)
                    .overlay(
                        NavigationLink(value: contact, label: {
                            EmptyView()
                        }).opacity(0)
                    )
            }
        }
        .listStyle(PlainListStyle())
        .padding(.horizontal, ConstantsSize.contactListHorizontalPadding)
    }
}

private struct ConstantsSize {
    static let contactRowVerticalPadding: CGFloat = 5
    static let contactListHorizontalPadding: CGFloat = 8
}

private struct ConstantsColor {
    static let backgroundColor = "BackgroundColor"
}

//#Preview {
//    ContactListView(contacts: [Contact(avatar: nil, initials: "МА", name: "M A", isOnline: true, hasStory: true, lastSeen: "online", phoneNumber: "1234")])
////    ContactListView(contacts: [Contact(avatar: nil, initials: "МА", name: "M A", isOnline: true, hasStory: true, lastSeen: "online", phoneNumber: "1234")], selectedContact: .constant(nil), showDetail: .constant(false) )
//}
