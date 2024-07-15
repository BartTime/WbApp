import SwiftUI

struct VerificationCode: View {
    @State private var shakeEffect: CGFloat = 0
    @State private var code: String = ""
    @FocusState private var isFieldFocused: Bool
    private let maxDigits = 4
    
    private var verificationInfo = VerificationInfo(code: "1234", phoneNumber: "+7 999 999-99-99")
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Text("EnterCode".localizableString("ru"))
                    .modifier(Heading2())
                
                Text("\("SendCodeOnNumber".localizableString("ru"))\n\(verificationInfo.phoneNumber)")
                    .modifier(BodyText2())
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .lineLimit(2)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                HStack(spacing: 40) {
                    ForEach(0..<maxDigits, id: \.self) { index in
                        CodeImageView(digit: digit(at: index))
                            .frame(width: 32, height: 40)
                            .onTapGesture {
                                isFieldFocused = true
                            }
                        
                    }
                }
                .padding(.horizontal)
                .padding(.top, 49)
                .modifier(ShakeEffect(amount: 10, shakesPerUnit: 3, animatableData: shakeEffect))
                .onTapGesture {
                    isFieldFocused = true
                }
                
                SecureField("", text: $code)
                    .keyboardType(.numberPad)
                    .focused($isFieldFocused)
                    .foregroundStyle(.clear)
                    .frame(width: 0, height: 0)
                    .onChange(of: code, perform: handleCodeChange)
                    .accessibility(hidden: true)
                
                Button(action: sendNewCode) {
                    Text("GetCodeOneMore".localizableString("ru"))
                        .modifier(Subheading2())
                        .foregroundStyle(Color("buttonTextColor"))
                }
                .padding(.horizontal)
                .padding(.top, 81)
            }
        }
        .onTapGesture {
            isFieldFocused = false
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    print("back")
                } label: {
                    Image("chevron")
                        .resizable()
                        .modifier(NavigationIconStyleNav())
                        .padding(.leading, 8)
                }
                
            }
        }
    }
    
    private func digit(at index: Int) -> String {
        guard index < code.count else { return "" }
        return String(code[code.index(code.startIndex, offsetBy: index)])
    }
    
    private func handleCodeChange(_ newValue: String) {
        if newValue.count > maxDigits {
            code = String(newValue.prefix(maxDigits))
            
            if code.count == maxDigits {
                if verificationInfo.isValidCode(code) {
                    print("Код введен верно!")
                } else {
                    withAnimation(.bouncy) {
                        shakeEffect += 1
                    }
                }
            }
        }
    }
    
    private func sendNewCode() {
        
    }
}

#Preview {
    VerificationCode()
}
