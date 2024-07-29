import Foundation

enum Tabs: String, CaseIterable {
    case contacts = "Contacts"
    case chats = "Chats"
    case more = "More"
    
    static func convert(from: String) -> Self? {
        return Tabs.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
