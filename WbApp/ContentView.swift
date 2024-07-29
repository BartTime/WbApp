import SwiftUI

struct ContentView: View {
    @StateObject private var appData: AppData = .shared
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        TabBarView()
            .environment(\.managedObjectContext, context)
            .environmentObject(appData)
            .onOpenURL { url in
                appData.handleDeepLink(url: url)
            }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.context)
}
