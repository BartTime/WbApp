import SwiftUI

struct VerificationView: View {
    @State private var selectedCountryIndex = 0
    @State private var phoneNumber: String = ""
    @State private var showCountryPicker = false
    @State private var showAllert = false
    @State private var allertMessage = ""
    @State private var isLoading = false
    
    let countries = Country.getCountries()
    
    var body: some View {
        ZStack {
            
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Text("EnterPhoneNumber".localizableString("ru"))
                    .modifier(Heading2())
                    .padding(.horizontal)
                
                Text("CodeVerificationNumber".localizableString("ru"))
                    .modifier(BodyText2())
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top, 8)
                    .padding(.horizontal)
                
                
                HStack {
                    Button(action: { showCountryPicker.toggle() }) {
                        Image(countries[selectedCountryIndex].flagImageName)
                            .resizable()
                            .cornerRadius(4)
                            .frame(width: 16, height: 16)
                        Text(countries[selectedCountryIndex].code)
                            .modifier(BodyText1())
                            .foregroundStyle(Color("grayColor"))
                    }
                    
                    .padding()
                    .frame(height: 36)
                    .background(Color("textFieldVerification"))
                    .cornerRadius(4)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(Color("textFieldVerification"))
                            .frame(height: 36)
                        
                        PhoneNumberTextField(phoneNumber: $phoneNumber, mask: countries[selectedCountryIndex].phonecode)
                            .onChange(of: selectedCountryIndex, perform: { value in
                                phoneNumber = ""
                            })
                    }
                }
                
                .padding(.top, 49)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                
                .sheet(isPresented: $showCountryPicker, content: {
                    CountyPickeView(selectedCountryIndex: $selectedCountryIndex, countries: countries)
                })
                
                ButtonView(buttonAction: validatePhoneNumber, buttonText: "Continue".localizableString("ru"), isDisabled: phoneNumber.isEmpty)
                    .padding(.top, 69)
                    .alert(isPresented: $showAllert, content: {
                        Alert(title: Text("BaseError".localizableString("ru")), message: Text(allertMessage), dismissButton: .default(Text("Ok".localizableString("ru"))))
                    })
                    .opacity(isLoading ? 0.0 : 1.0)
                    .contentTransition(.opacity)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                        .padding(.horizontal)
                }
            }
        }
        .hideKeyboardOnTap()
    }
    
    private func validatePhoneNumber() {
        let selectedCountry = countries[selectedCountryIndex]
        
        let regex = selectedCountry.regex
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
        
        if phoneTest.evaluate(with: phoneNumber) {
            go()
        } else {
            allertMessage = "\("NumberOfPhoneNotConfirm".localizableString("ru")) \(selectedCountry.name)."
            showAllert = true
        }
    }
    private func go() {
        withAnimation(.bouncy.speed(1.2)) {
            isLoading = true
        }
    }
}

#Preview {
    VerificationView()
}
