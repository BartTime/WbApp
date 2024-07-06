import SwiftUI

struct PhoneNumberTextField: View {
    @Binding var phoneNumber: String
    var mask: String
    
    var body: some View {
        VStack {
            TextField(mask, text: $phoneNumber)
                .keyboardType(.numberPad)
                .modifier(BodyText1())
                .foregroundStyle(Color("grayColor"))
                .onChange(of: phoneNumber) { newValue in
                    phoneNumber = formatPhoneNumber(newValue)
                }
        }
        .padding()
    }
    
    private func formatPhoneNumber(_ number: String) -> String {
        let cleanedPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = self.mask
        
        var result = ""
        var index = cleanedPhoneNumber.startIndex
        
        for ch in mask {
            if index == cleanedPhoneNumber.endIndex {
                break
            }
            
            if ch == "0" {
                result.append(cleanedPhoneNumber[index])
                index = cleanedPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
}
