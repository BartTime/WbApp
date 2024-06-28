import SwiftUI

struct InitialsView: View {
    let initials: String
    let hasStory: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: ConstantsSize.initialsCornerRadius)
            .fill(Color.purple)
            .frame(width: ConstantsSize.avatarSize, height: ConstantsSize.avatarSize)
            .overlay(
                Text(initials)
                    .modifier(InitialsTextStyle())
            )
            .overlay(StoryBorderOverlay(hasStory: hasStory, avatar: nil))
    }
}

private struct ConstantsSize {
    static let avatarSize: CGFloat = 48
    static let initialsCornerRadius: CGFloat = 18
}

#Preview {
    InitialsView(initials: "", hasStory: true)
}
