import SwiftUI

@main
struct WbAppApp: App {
    @StateObject private var appData: AppData = .shared
    let coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
                .environment(\.managedObjectContext, coreDataManager.context)
        }
    }
}
