import SwiftUI

struct CountyPickeView: View {
    @Binding var selectedCountryIndex: Int
    @Environment(\.dismiss) private var dismiss
    let countries: [Country]
    
    var body: some View {
        NavigationView {
            List(countries.indices, id: \.self) { index in
                Button {
                    selectedCountryIndex = index
                    dismiss()
                } label: {
                    HStack {
                        Image(countries[index].flagImageName)
                            .resizable()
                            .frame(width: 16, height: 16)
                        
                        Text(countries[index].name)
                        
                        Spacer()
                        
                        Text(countries[index].code)
                    }
                    .padding()
                    .background(selectedCountryIndex == index ? .blue.opacity(0.3) : .clear)
                    .cornerRadius(8)
                }
                
            }
            .navigationTitle("Selected Country")
            
        }
    }
}
