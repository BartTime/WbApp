import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appData: AppData
    var contact: Contacts

    var body: some View {
            ZStack {
                Color(Constants.Colors.backgroundColor)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer().frame(height: Constants.Layout.spacerHeight)

                    ProfileImageView(contact: contact)

                    VStack(spacing: Constants.Layout.spacingBetweenTexts) {
                        Text(contact.name ?? "no name")
                            .padding(.top, Constants.Layout.topPadding)
                            .modifier(TitleStyleContacts())

                        Text(contact.phoneNumber ?? "no telephone")
                            .font(.system(size: Constants.FontSizes.phoneNumber, weight: .semibold))
                            .foregroundColor(.gray)
                    }

                    SocialMediaButtons()
                        .padding(.top, Constants.Layout.socialMediaTopPadding)

                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                            appData.removeContactFromNavStack(contact: contact)
                        } label: {
                            HStack {
                                Image("chevron")
                                    .resizable()
                                    .modifier(NavigationIconStyleNav())
                                    .padding(.leading, Constants.Layout.iconPadding)
                                Text("Контакты")
                                    .modifier(Subheading1())
                                    .foregroundColor(.primary)
                            }
                        }
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image("edit")
                        .resizable()
                        .modifier(RightIconsStyleNav())
                }
            }
    }
}

private struct ProfileImageView: View {
    var contact: Contacts
    
    var body: some View {
        ZStack {
            if let avatar = contact.avatar, !avatar.isEmpty {
                Image(avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constants.Layout.frameSize, height: Constants.Layout.frameSize)
                    .clipShape(Circle())
                    .clipped()
            } else if contact.initials == nil {
                Circle()
                    .fill(Color(Constants.Colors.backgroundCircle))
                    .frame(width: Constants.Layout.frameSize, height: Constants.Layout.frameSize)
                    .overlay(
                        Image("Person")
                            .foregroundColor(.white)
                            .font(.title)
                    )
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: Constants.Layout.frameSize, height: Constants.Layout.frameSize)
                    .overlay(
                        Text(contact.initials ?? "")
                            .foregroundColor(.white)
                            .font(.title)
                    )
            }
        }
        .background(Circle().fill(Color(Constants.Colors.backgroundCircle)))
        .padding(.top, Constants.Layout.imageTopPadding)
    }
}

private struct SocialMediaButtons: View {
    private let buttons = Constants.SocialMediaButtons.buttons
    
    var body: some View {
        HStack(spacing: Constants.Layout.buttonSpacing) {
            ForEach(buttons, id: \.0) { (imageName, actionName) in
                SocialMediaButton(imageName: imageName, actionName: actionName)
            }
        }
    }
}

private struct SocialMediaButton: View {
    var imageName: String
    var actionName: String
    
    var body: some View {
        Button(action: {
            print("\(actionName) action tapped")
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Layout.buttonIconSize, height: Constants.Layout.buttonIconSize)
                .foregroundColor(.purple)
        }
        .frame(width: Constants.Layout.buttonWidth, height: Constants.Layout.buttonHeight)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.Layout.buttonCornerRadius)
                .stroke(Color.purple, lineWidth: Constants.Layout.buttonBorderWidth)
        )
    }
}

private struct Constants {
    struct Layout {
        static let spacerHeight: CGFloat = 13
        static let frameSize: CGFloat = 200
        static let imageTopPadding: CGFloat = 46
        static let topPadding: CGFloat = 20
        static let spacingBetweenTexts: CGFloat = 4
        static let socialMediaTopPadding: CGFloat = 40
        static let buttonSpacing: CGFloat = 12
        static let buttonIconSize: CGFloat = 20
        static let buttonWidth: CGFloat = 72
        static let buttonHeight: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 25
        static let buttonBorderWidth: CGFloat = 1.67
        static let iconPadding: CGFloat = 8
    }
    
    struct Colors {
        static let backgroundCircle = "backgroundCircle"
        static let backgroundColor = "BackgroundColor"
    }
    
    struct Titles {
        static let contactTitle = "Контакты"
    }
    
    struct FontSizes {
        static let phoneNumber: CGFloat = 16
    }
    
    struct SocialMediaButtons {
        static let buttons = [
            ("twitter", "Twitter"),
            ("instagram", "Instagram"),
            ("LinkedIn", "LinkedIn"),
            ("facebook", "Facebook")
        ]
    }
}

//#Preview {
//    ProfileView(contact: Contact(avatar: nil, initials: "М А", name: "Марина Васильевна", isOnline: false, hasStory: false, lastSeen: ""), showDetail: .constant(false))
//}
