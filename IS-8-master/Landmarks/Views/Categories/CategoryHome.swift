/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of landmarks grouped by category.
*/

import SwiftUI

struct CategoryHome: View {
    @Environment(ModelData.self) var modelData
    @State private var showingProfile = false
    @State private var draftProfile = Profile.default

    var body: some View {
        NavigationSplitView {
            List {
                modelData.features[safe: 0]?.image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())

                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        ProfileHost(draftProfile: $draftProfile)
                    }, label: {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundStyle(Color.green)
                    })
                }
            }
        } detail: {
            Text("Select a Landmark")
        }
    }
    
}

#Preview {
    CategoryHome()
        .environment(ModelData())
}

