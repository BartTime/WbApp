import SwiftUI

struct AvatarView: View {
    let contact: Contacts
    @EnvironmentObject var imageLoader: ImageLoader
    
    @State private var image: UIImage? = nil

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
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
        .onAppear {
            imageLoader.loadImage(from: contact.imageUrl ?? "") { loadedImage in
                self.image = loadedImage
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
