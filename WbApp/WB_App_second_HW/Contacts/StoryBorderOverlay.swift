import SwiftUI

struct StoryBorderOverlay: View {
    let hasStory: Bool
    let avatar: String?
    
    var body: some View {
        let hasAvatar = avatar != nil
        let gradient = hasAvatar ? avatarGradient() : noAvatarGradient()
                
        return RoundedRectangle(cornerRadius: ConstantsSize.storyBorderCornerRadius)
            .stroke(
                gradient,
                lineWidth: hasStory ? ConstantsSize.storyBorderWidth : 0
            )
            .frame(width: ConstantsSize.storyBorderSize, height: ConstantsSize.storyBorderSize)
    }
    
    private func avatarGradient() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [ConstantsColor.avatarGradientColorFirstPoint, ConstantsColor.avatarGradientColorSecondPoint]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private func noAvatarGradient() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [ConstantsColor.noAvatarGradientColorFirstPoint, ConstantsColor.noAvatarGradientColorSecondPoint]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

private struct ConstantsSize {
    static let storyBorderWidth: CGFloat = 2.5
    static let storyBorderCornerRadius: CGFloat = 20
    static let storyBorderSize: CGFloat = 56
}

private struct ConstantsColor {
    static let avatarGradientColorFirstPoint = Color(red: 210/255, green: 213/255, blue: 249/255)
    static let avatarGradientColorSecondPoint = Color(red: 44/255, green: 55/255, blue: 225/255)
    static let noAvatarGradientColorFirstPoint = Color(red: 236/255, green: 158/255, blue: 255/255)
    static let noAvatarGradientColorSecondPoint = Color(red: 95/255, green: 46/255, blue: 234/255)
}

#Preview {
    StoryBorderOverlay(hasStory: true, avatar: nil)
}


