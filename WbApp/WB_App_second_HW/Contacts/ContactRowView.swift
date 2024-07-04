import SwiftUI

struct ContactRowView: View {
    let contact: Contact
    
    var body: some View {
        HStack(alignment: .top) {
            AvatarView(contact: contact)
                .padding(.trailing, ConstantsSize.avatarTrailingPadding)
            
            VStack(alignment: .leading) {
                Text(contact.name)
                    .modifier(BodyText1())
                    .font(.system(size: ConstantsFont.nameTextSize, weight: .semibold))
                    .padding(.bottom, ConstantsSize.nameTextBottomPadding)
                Text(contact.lastSeen)
                    .modifier(Metadata1())
                    .foregroundColor(Color(ConstantsColor.lastSeenTextColor))
            }
        }
        .overlay {
 //            MARK: Раскомнетить для базового перехода
//             NavigationLink("", destination: ProfileView(contact: contact))
//                            .opacity(0)
                
        }
        
    }
}

private struct ConstantsSize {
    static let avatarTrailingPadding: CGFloat = 10
    static let nameTextBottomPadding: CGFloat = 4
}

private struct ConstantsFont {
    static let nameTextSize: CGFloat = 14
}

private struct ConstantsColor {
    static let backgroundColor = "BackgroundColor"
    static let lastSeenTextColor = "grayColor"
}
#Preview {
    ContactRowView(contact: Contact(avatar: "", initials: "МА", name: "Маман", isOnline: true, hasStory: true, lastSeen: "Online", phoneNumber: "1234"))
}
