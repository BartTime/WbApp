import SwiftUI

// MARK: Раскомнетить для базового перехода и удалить метод

//struct ContactListView: View {
//    let contacts: [Contact]
//
//    var body: some View {
//        List(contacts) { contact in
//                ContactRowView(contact: contact)
//                    .listRowBackground(Color(ConstantsColor.backgroundColor))
//                    .padding(.vertical, ConstantsSize.contactRowVerticalPadding)
//
//        }
//        .listStyle(PlainListStyle())
//        .padding(.horizontal, ConstantsSize.contactListHorizontalPadding)
//    }
//}

struct ContactListView: View {
    let contacts: [Contact]
    @Binding var selectedContact: Contact?
    @Binding var showDetail: Bool
    
    var body: some View {
            List(contacts) { contact in
                ContactRowView(contact: contact)
                    .listRowBackground(Color(ConstantsColor.backgroundColor))
                    .padding(.vertical, ConstantsSize.contactRowVerticalPadding)
                    .onTapGesture {
                        self.selectedContact = contact
                        self.showDetail.toggle()
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

#Preview {
//    ContactListView(contacts: [Contact(avatar: nil, initials: "МА", name: "M A", isOnline: true, hasStory: true, lastSeen: "online")])
    ContactListView(contacts: [Contact(avatar: nil, initials: "МА", name: "M A", isOnline: true, hasStory: true, lastSeen: "online", phoneNumber: "1234")], selectedContact: .constant(nil), showDetail: .constant(false) )
}
