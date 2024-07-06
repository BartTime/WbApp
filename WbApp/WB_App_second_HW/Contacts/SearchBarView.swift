import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .modifier(IconStyleSearchField())
                .foregroundColor(searchText.isEmpty ? Color(ConstantsColor.searchTextFieldTextColor) : Color(ConstantsColor.textFieldTextColor))
                .padding(ConstantsSize.searchIconPadding)
            TextField("Search", text: $searchText)
                .modifier(BodyText1())
                .foregroundColor(Color(ConstantsColor.textFieldTextColor))
        }
        .background(Color(ConstantsColor.searchTextField))
        .cornerRadius(ConstantsSize.searchFieldCornerRadius)
        .padding(.horizontal, ConstantsSize.horizontalPadding)
        .padding(.bottom, ConstantsSize.searchFieldBottomPadding)
    }
}

private struct ConstantsSize {
    static let searchIconPadding: CGFloat = 8
    static let searchFieldCornerRadius: CGFloat = 4
    static let searchFieldBottomPadding: CGFloat = 6
    static let horizontalPadding: CGFloat = 24
}

private struct ConstantsColor {
    static let searchTextField = "searchTextField"
    static let searchTextFieldTextColor = "grayColor"
    static let textFieldTextColor = "textFieldTextColor"
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
