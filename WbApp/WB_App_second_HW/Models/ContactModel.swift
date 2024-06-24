import Foundation

struct Contact: Identifiable, Hashable {
    let id = UUID()
    let avatar: String?
    let initials: String?
    let name: String
    let isOnline: Bool
    let hasStory: Bool
    let lastSeen: String
    let phoneNumber: String
}

let contacts = [
    Contact(avatar: "anastasia", initials: nil, name: "Анастасия Иванова", isOnline: false, hasStory: false, lastSeen: "Last seen yesterday", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: "anastasia", initials: nil, name: "Петя", isOnline: true, hasStory: false, lastSeen: "Online", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: "maman", initials: nil, name: "Маман", isOnline: false, hasStory: true, lastSeen: "Last seen 3 hours ago", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: "anastasia", initials: nil, name: "Арбуз Дыня", isOnline: true, hasStory: false, lastSeen: "Online", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: nil, initials: "ИИ", name: "Иван Иванов", isOnline: true, hasStory: false, lastSeen: "Online", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: nil, initials: "ЛА", name: "Лиса Алиса", isOnline: false, hasStory: true, lastSeen: "Last seen 30 minutes ago", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: "maman", initials: nil, name: "Маман", isOnline: false, hasStory: true, lastSeen: "Last seen 3 hours ago", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: "anastasia", initials: nil, name: "Арбуз Дыня", isOnline: true, hasStory: false, lastSeen: "Online", phoneNumber: "+7 999 999-99-99"),
    Contact(avatar: nil, initials: "ИИ", name: "Иван Иванов", isOnline: true, hasStory: false, lastSeen: "Online", phoneNumber: "+7 999 999-99-99")
]
