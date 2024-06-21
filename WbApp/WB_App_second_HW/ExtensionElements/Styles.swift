import SwiftUI

struct TitleStyleContacts: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: ConstantsFont.titleSizeContacts, weight: .bold))
            .foregroundColor(Color(ConstantsColor.textColor))
    }
}

struct IconStyleSearchField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: ConstantsFont.iconSize))
    }
}

struct InitialsTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: ConstantsFont.initialsTextSize, weight: .bold))
            .foregroundColor(.white)
    }
}

struct Heading1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold))
    }
}

struct Heading2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold))
    }
}

struct Subheading1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .semibold))
    }
}

struct Subheading2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold))
    }
}

struct BodyText1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .semibold))
    }
}

struct BodyText2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular))
    }
}

struct Metadata1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .regular))
    }
}

struct Metadata2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .regular))
    }
}

struct Metadata3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .semibold))
    }
}

struct NavigationIconStyleNav: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: IconsStyle.width, height: IconsStyle.height)
            .foregroundColor(IconsStyle.foregroundColor)
    }
}

struct RightIconsStyleNav: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: IconsStyle.width, height: IconsStyle.height)
            .foregroundColor(IconsStyle.foregroundColor)
    }
}

private struct IconsStyle {
    static let width: CGFloat = 24
    static let height: CGFloat = 24
    static let foregroundColor: Color = .primary
}

private struct ConstantsColor {
    static let searchTextField = "searchTextField"
    static let textColor = "TextColor"
    
    static let searchTextFieldTextColor = "grayColor"
    static let lastSeenTextColor = "grayColor"
}

private struct ConstantsFont {
    static let lastSeenTextSize: CGFloat = 12
    static let searchFieldSize: CGFloat = 14
    static let iconSize: CGFloat = 22
    static let nameTextSize: CGFloat = 14
    static let titleSize: CGFloat = 18
    static let initialsTextSize: CGFloat = 14
    static let titleSizeContacts: CGFloat = 24
}

private struct ConstantsSize {
    static let nameTextBottomPadding: CGFloat = 4
}
