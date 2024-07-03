import SwiftUI

private struct StyledRoundeedRectangle: View {
    let width: CGFloat
    let height: CGFloat
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 80)
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
            .frame(width: width, height: height)
            .foregroundStyle(color)
    }
}

private struct DoubleVStack: View {
    let firstColor: Color
    let secondColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
            StyledRoundeedRectangle(width: 200, height: 100, color: firstColor)
            StyledRoundeedRectangle(width: 200, height: 100, color: secondColor)
        }
    }
}

private struct DoubleHStack: View {
    let firstColor: Color
    let secondColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            StyledRoundeedRectangle(width: 150, height: 100, color: firstColor)
            StyledRoundeedRectangle(width: 150, height: 100, color: secondColor)
        }
    }
}

private struct FirstView: View {
    var body: some View {
        HStack(spacing: 20) {
            StyledRoundeedRectangle(width: 100, height: 220, color: .blue)
            DoubleVStack(firstColor: .black, secondColor: .black)
        }
    }
}

private struct SecondView: View {
    var body: some View {
        HStack(spacing: 20) {
            StyledRoundeedRectangle(width: 100, height: 220, color: .blue)
            DoubleVStack(firstColor: .black, secondColor: .black)
        }
    }
}

private struct ThirdView: View {
    var body: some View {
        VStack(spacing: 20) {
            StyledRoundeedRectangle(width: 320, height: 100, color: .black)
            DoubleHStack(firstColor: .black, secondColor: .blue)
        }
    }
}

private struct FourthView: View {
    var body: some View {
        VStack(spacing: 20) {
            DoubleHStack(firstColor: .black, secondColor: .blue)
            StyledRoundeedRectangle(width: 320, height: 100, color: .black)
        }
    }
}

struct InfinityScrollView: View {
    @State private var items: [AnyView] = []
    @State private var loaadingMore = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items.indices, id: \.self) { index in
                    ZStack {
                        Text(String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!))
                            .font(.system(size: 100))
                            .opacity(0.5)
                        
                        items[index]
                            .onAppear {
                                if index == items.count - 2 {
                                    loadMore()
                                }
                            }
                    }
                    Divider()
                }
                
                if loaadingMore {
                    ProgressView()
                        .frame(height: 50)
                }
            }
        }
        .onAppear {
            loadMore()
        }
    }
    
    private func loadMore() {
        guard !loaadingMore else { return }
        loaadingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let newItems = (0..<10).map { _ in AnyView(getRandomView()) }
            items.append(contentsOf: newItems)
            loaadingMore = false
        }
    }
    
    @ViewBuilder
    private func getRandomView() -> some View {
        switch Int.random(in: 0..<4) {
        case 0:
            FirstView()
        case 1:
            SecondView()
        case 2:
            ThirdView()
        default:
            FourthView()
        }
    }
}

#Preview {
    InfinityScrollView()
}
