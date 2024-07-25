import SwiftUI

public struct ButtonView: View {
    let buttonAction: () -> Void
    let buttonText: String
    
    public var body: some View {
        Button(action: buttonAction) {
            Text(buttonText)
                .font(.system(size: ConstantsSize.buttonTextSize, weight: .semibold))
                .frame(width: ConstantsSize.buttonWidth, height: ConstantsSize.buttonHeight)
                .background(Color(ConstantsColor.buttonBackgroundColor))
                .foregroundColor(.white)
                .cornerRadius(ConstantsSize.buttonCornerRadius)
        }
    }
}

private struct ConstantsSize {
    static let buttonWidth: CGFloat = 327
    static let buttonHeight: CGFloat = 52
    static let buttonCornerRadius: CGFloat = 30
    
    static let buttonTextSize: CGFloat = 16
}

private struct ConstantsColor {
    static let buttonBackgroundColor = "buttonBackgroundColor"
}

