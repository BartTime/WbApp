import AppIntents

struct OpenContactsTabBarIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Contacts Tab"
    
    static var openAppWhenRun: Bool = true
    
    func perform() async throws -> some IntentResult {
        DispatchQueue.main.async {
            AppData.shared.activeTab = .contacts
        }
        return .result()
    }
}

struct OpenChatsTabBarIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Chats Tab"
    
    static var openAppWhenRun: Bool = true
    
    func perform() async throws -> some IntentResult {
        DispatchQueue.main.async {
            AppData.shared.activeTab = .chats
        }
        return .result()
    }
}

struct OpenMoreTabBarIntent: AppIntent {
    static var title: LocalizedStringResource = "Open More Tab"
    
    static var openAppWhenRun: Bool = true
    
    func perform() async throws -> some IntentResult {
        DispatchQueue.main.async {
            AppData.shared.activeTab = .more
        }
        return .result()
    }
}
