import SwiftUI

extension View {
    func customNavBar(
        title: String? = nil,
        leftButtonImage: (name: String, isSystem: Bool)? = nil,
        rightButtonImages: [(name: String, isSystem: Bool)] = [],
        leftButtonAction: (() -> Void)? = nil,
        rightButtonActions: [() -> Void] = []
    ) -> some View {
        self.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    if let leftButtonImage = leftButtonImage, let leftButtonAction = leftButtonAction {
                        Button(action: leftButtonAction) {
                            if leftButtonImage.isSystem {
                                Image(systemName: leftButtonImage.name)
                                    .modifier(NavigationIconStyleNav())
                            } else {
                                Image(leftButtonImage.name)
                                    .resizable()
                                    .modifier(NavigationIconStyleNav())
                            }
                        }
                        .padding(.leading, ConstantsSize.horizontalPadding)
                    }
                    
                    if let title = title {
                        Text(title)
                            .modifier(Subheading1())
                            .foregroundColor(.primary)
                            .padding(.leading, leftButtonImage != nil ? 0 : ConstantsSize.horizontalPadding)
                    }
                }
            }
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                ForEach(Array(rightButtonImages.enumerated()), id: \.offset) { index, image in
                    if index < rightButtonActions.count {
                        Button(action: rightButtonActions[index]) {
                            if image.isSystem {
                                Image(systemName: image.name)
                                    .modifier(RightIconsStyleNav())
                            } else {
                                Image(image.name)
                                    .resizable()
                                    .modifier(RightIconsStyleNav())
                            }
                        }
                        .padding(.trailing, ConstantsSize.horizontalPadding)
                    }
                }
            }
        }
    }
}

private struct ConstantsSize {
    static let horizontalPadding: CGFloat = 8
}


struct CustomNavBarTest: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Main Screen")
                    .padding()

                NavigationLink(destination: SecondViewNavBarTest()) {
                    Text("Go to Second Screen")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .customNavBar(
                title: "Main Screen",
                leftButtonImage: nil,
                rightButtonImages: [("bell", true)],
                rightButtonActions: [
                    { print("Bell tapped") }
                ]
            )
        }
    }
}

struct SecondViewNavBarTest: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Second Screen")
                .padding()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .customNavBar(
            title: "Second Screen",
            leftButtonImage: ("chevron.left", true),
            rightButtonImages: [("customImage", false)],
            leftButtonAction: {
                dismiss()
            },
            rightButtonActions: [
                { print("Gear tapped") }
            ]
        )
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarTest()
    }
}
