import SwiftUI

struct CodeImageView: View {
    var digit: String
    
    var body: some View {
        ZStack {
            if digit.isEmpty {
                Image("ellipsis")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .animation(.spring)
            } else {
                Text(digit)
                    .modifier(Heading1())
                    .transition(.opacity.combined(with: .scale))
            }
        }
    }
}
