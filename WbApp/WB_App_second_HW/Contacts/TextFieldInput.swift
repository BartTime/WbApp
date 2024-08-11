import SwiftUI

struct TextFieldInput: View {
    @Binding var searchText: String
    var showGlass: Bool
    var defaultText: String
    
    var body: some View {
        HStack {
            if showGlass {
                Image(systemName: "magnifyingglass")
                    .modifier(IconStyleSearchField())
                    .foregroundColor(searchText.isEmpty ? Color(ConstantsColor.searchTextFieldTextColor) : Color(ConstantsColor.textFieldTextColor))
                    .padding(ConstantsSize.searchIconPadding)
            }
            TextField(defaultText, text: $searchText)
                .modifier(BodyText1())
                .foregroundColor(Color(ConstantsColor.textFieldTextColor))
                .frame(minHeight: 36, maxHeight: 36)
        }
        .background(Color(ConstantsColor.searchTextField))
        .cornerRadius(ConstantsSize.searchFieldCornerRadius)
    }
}

private struct ConstantsSize {
    static let searchIconPadding: CGFloat = 8
    static let searchFieldCornerRadius: CGFloat = 4
}

private struct ConstantsColor {
    static let searchTextField = "searchTextField"
    static let searchTextFieldTextColor = "grayColor"
    static let textFieldTextColor = "textFieldTextColor"
}

#Preview {
    TextFieldInput(searchText: .constant(""), showGlass: true, defaultText: "Search")
}
