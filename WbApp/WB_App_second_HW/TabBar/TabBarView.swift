import SwiftUI

enum Tab {
    case contacts, chats, more
}

struct TabView: View {
    @Binding var tabIdx: Tab
    
    var body: some View {
        VStack(spacing: TabBarConstants.Layout.tabSpacing) {
            HStack(spacing: TabBarConstants.Layout.tabSpacing) {
                tabButton(systemName: "group", text: "Контакты", tab: .contacts)
                Spacer()
                tabButton(systemName: "message_circle", text: "Чаты", tab: .chats)
                Spacer()
                tabButton(systemName: "coolicon", text: "Еще", tab: .more)
            }
            Spacer()
        }
        .padding(.top, TabBarConstants.Layout.tabPaddingTop)
        .frame(height: TabBarConstants.Layout.tabHeight)
        .padding(.horizontal, TabBarConstants.Layout.tabPaddingHorizontal)
        .background(TabBarConstants.Colors.backgroundColor)
    }
    
    // MARK: TabBar с кружком внизу
//    private func tabButton(systemName: String, text: String, tab: Tab) -> some View {
//        Button(action: {
//            self.tabIdx = tab
//        }) {
//            VStack(spacing: TabBarConstants.Layout.tabSpacing) {
//                if self.tabIdx == tab {
//                    Text(text)
//                        .font(.system(size: TabBarConstants.Sizes.tabButtonTextSize, weight: .regular))
//                } else {
//                    Image(systemName: systemName)
//                        .font(.system(size: TabBarConstants.Sizes.tabButtonIconSize))
//                }
//
//                if self.tabIdx == tab {
//                    Circle()
//                        .frame(width: TabBarConstants.Sizes.tabButtonCircleSize, height: TabBarConstants.Sizes.tabButtonCircleSize)
//                        .padding(.top, TabBarConstants.Layout.tabButtonCirclePaddingTop)
//                }
//            }
//            .frame(width: TabBarConstants.Layout.tabButtonWidth, height: TabBarConstants.Layout.tabButtonHeight)
//        }
//        .foregroundColor(TabBarConstants.Colors.buttonColor)
//    }
    
    private func tabButton(systemName: String, text: String, tab: Tab) -> some View {
        Button(action: {
            self.tabIdx = tab
        }) {
            VStack(spacing: TabBarConstants.Layout.tabSpacing) {
                
                Image(systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: TabBarConstants.Sizes.tabButtonIconSize))
                    .foregroundStyle(self.tabIdx == tab ? TabBarConstants.Colors.selectedButtonColor : TabBarConstants.Colors.buttonColor)
                    .frame(width: 32, height: 32)
                
            }
            .frame(width: TabBarConstants.Layout.tabButtonWidth, height: TabBarConstants.Layout.tabButtonHeight)
        }
    }
}

struct TabBarView: View {
    @State var tabIdx: Tab = .contacts
    
    var body: some View {
        VStack(spacing: TabBarConstants.Layout.tabSpacing) {
            Spacer()
            switch tabIdx {
            case .contacts:
                // MARK: Раскомнетить для базового перехода и удалить метод
//                ContactsView()
                ContactsViewAnimate()
            case .chats:
                Text("Чаты")
            case .more:
                Text("Еще")
            }
            Spacer(minLength: 0)
            TabView(tabIdx: $tabIdx)
                .shadow(radius: TabBarConstants.Layout.shadowRadius)
            
        }
        .ignoresSafeArea()
    }
}

private struct TabBarConstants {
    struct Layout {
        static let tabHeight: CGFloat = 83
        static let tabPaddingTop: CGFloat = 12
        static let tabPaddingHorizontal: CGFloat = 16
        static let tabSpacing: CGFloat = 0
        static let tabButtonWidth: CGFloat = 58
        static let tabButtonHeight: CGFloat = 44
        static let tabButtonCirclePaddingTop: CGFloat = 8
        static let shadowRadius: CGFloat = 2
    }
    struct Sizes {
        static let tabButtonTextSize: CGFloat = 14
        static let tabButtonIconSize: CGFloat = 24
        static let tabButtonCircleSize: CGFloat = 4
        static let tabButtonCirclePaddingTop: CGFloat = 8
    }
    
    struct Colors {
        static let backgroundColor = Color("BackgroundColor")
        static let buttonColor = Color("userAgreementButtonTextColor")
        static let selectedButtonColor = Color("navBarSelectedColor")
    }
}

#Preview {
    TabBarView()
}
