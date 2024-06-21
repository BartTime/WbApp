import SwiftUI

struct AvatarView: View {
    let contact: Contacts
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let avatar = contact.avatar {
                Image(avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ConstantsSize.avatarSize, height: ConstantsSize.avatarSize)
                    .clipShape(RoundedRectangle(cornerRadius: ConstantsSize.avatarCornerRadius))
                    .overlay(StoryBorderOverlay(hasStory: contact.hasStory, avatar: contact.avatar))
            } else if let initials = contact.initials {
                InitialsView(initials: initials, hasStory: contact.hasStory)
            }
            
            if contact.isOnline {
                OnlineStatusIndicator()
            }
        }
    }
}

private struct ConstantsSize {
    static let avatarSize: CGFloat = 48
    static let avatarCornerRadius: CGFloat = 16
}

//#Preview {
//    AvatarView(contact: Contact(avatar: "", initials: "", name: "", isOnline: true, hasStory: true, lastSeen: "", phoneNumber: "123"))
//}
