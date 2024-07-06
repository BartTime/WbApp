import SwiftUI

struct OnlineStatusIndicator: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: ConstantsSize.onlineIndicatorOuterSize, height: ConstantsSize.onlineIndicatorOuterSize)
                .offset(x: ConstantsSize.onlineIndicatorOffset, y: -ConstantsSize.onlineIndicatorOffset)
            Circle()
                .fill(Color.green)
                .frame(width: ConstantsSize.onlineIndicatorInnerSize, height: ConstantsSize.onlineIndicatorInnerSize)
                .offset(x: ConstantsSize.onlineIndicatorOffset, y: -ConstantsSize.onlineIndicatorOffset)
        }
    }
}

private struct ConstantsSize {
    static let onlineIndicatorOuterSize: CGFloat = 16
    static let onlineIndicatorInnerSize: CGFloat = 12
    static let onlineIndicatorOffset: CGFloat = 3
}

#Preview {
    OnlineStatusIndicator()
}
