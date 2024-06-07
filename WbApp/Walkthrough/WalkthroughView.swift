import SwiftUI

struct WalkthroughView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack {
            illustrationImage
                .padding(.top, ConstantsSize.illustrationTopPadding)
            
            walkthroughText
                .padding(.top, ConstantsSize.walkthroughTextTopPadding)
            
            Spacer()
            
            userAgreementButton
                .padding(.bottom, ConstantsSize.userAgreementButtonBottomPadding)
            
            ButtonView(buttonAction: showSheet, buttonText: ConstantsName.startChattingButtonText)
                .padding(.bottom, ConstantsSize.startChattingButtonBottomPadding)
        }
        .padding(.horizontal, ConstantsSize.horizontalPadding)
        .background(Color(ConstantsColor.backgroundColor))
        .sheet(isPresented: $isSheetPresented) {
            SheetView(isSheetPresented: $isSheetPresented)
        }
    }
    
    private var illustrationImage: some View {
        Image(colorScheme == .dark ? ConstantsName.illustrationImageNameDark : ConstantsName.illustrationImageNameLight)
    }
    
    private var walkthroughText: some View {
        Text(ConstantsName.walkthroughText)
            .font(.system(size: ConstantsSize.walkthroughTextSize, weight: .bold))
            .multilineTextAlignment(.center)
    }
    
    private var userAgreementButton: some View {
        Button(action: {
            isSheetPresented = true
        }) {
            Text(ConstantsName.userAgreementButtonText)
                .font(.system(size: ConstantsSize.userAgreementButtonTextSize, weight: .semibold))
                .foregroundColor(Color(ConstantsColor.userAgreementButtonTextColor))
        }.sheet(isPresented: $isSheetPresented, content: {
            SheetView(isSheetPresented: $isSheetPresented)
        })
    }
    
    private func showSheet() {
        isSheetPresented = true
    }
}

private struct ConstantsName {
    static let illustrationImageNameLight = "Illustration"
    static let illustrationImageNameDark = "IllustrationDark"
    static let walkthroughText = "Общайтесь с друзьями и близкими легко"
    static let userAgreementButtonText = "Пользовательское соглашение"
    static let startChattingButtonText = "Начать общаться"
}

private struct ConstantsSize {
    static let illustrationTopPadding: CGFloat = 45
    static let walkthroughTextTopPadding: CGFloat = 42
    static let userAgreementButtonBottomPadding: CGFloat = 18
    static let startChattingButtonBottomPadding: CGFloat = 20
    
    static let walkthroughTextSize: CGFloat = 24
    static let userAgreementButtonTextSize: CGFloat = 14
    
    static let horizontalPadding: CGFloat = 40
}

private struct ConstantsColor {
    static let backgroundColor = "BackgroundColor"
    static let userAgreementButtonTextColor = "userAgreementButtonTextColor"
}

#Preview {
    WalkthroughView()
}
