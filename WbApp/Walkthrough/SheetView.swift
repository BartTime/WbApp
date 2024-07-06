import SwiftUI

struct SheetView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        VStack {
            Text(ConstantsName.textModal)
                .font(.title)
                .padding()
            
            ButtonView(buttonAction: closeSheet, buttonText: ConstantsName.backButtonText, isDisabled: false)
        }
        .padding()
    }
    
    private func closeSheet() {
        isSheetPresented = false
    }
}

private struct ConstantsName {
    static let textModal: String = "Это модальное окно"
    static let backButtonText: String = "Вернуться на главный экран"
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

#Preview {
    SheetView(isSheetPresented: .constant(false))
}
