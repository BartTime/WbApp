import WidgetKit
import SwiftUI
import CoreData

struct WidgetDeepLinkEntry: TimelineEntry {
    var date: Date
    var contacts: [Contacts]
}

struct WidgetDeepLinkProvider: TimelineProvider {
    private func getContacts() -> [Contacts] {
        let contactManager = ContactManager.shared
        return contactManager.loadFirstFourContacts()
    }
    
    func placeholder(in context: Context) -> WidgetDeepLinkEntry {
        let contacts = getContacts()
        return WidgetDeepLinkEntry(date: Date(), contacts: contacts)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetDeepLinkEntry) -> Void) {
        let contacts = getContacts()
        return completion(WidgetDeepLinkEntry(date: Date(), contacts: contacts))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetDeepLinkEntry>) -> Void) {
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: Date())!
        let contacts = getContacts()
        let timeline = Timeline(entries: [WidgetDeepLinkEntry(date: Date(), contacts: contacts)], policy: .after(refreshDate))
        completion(timeline)
    }
}

struct WidgetDeepLinkEntryView: View {
    @State var entry: WidgetDeepLinkProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            if !entry.contacts.isEmpty {
                ForEach(entry.contacts) { item in
                    Link(destination: URL(string: "wb5://?tab=home&id=\(item.id!)")!) {
                        HStack {
                            AvatarViewWidget(contact: item)
                            Text(item.name ?? "no name")
                        }
                    }
                }
            } else {
                Text("Нет данных")
            }
        }
        .padding()
    }
}

struct AvatarViewWidget: View {
    let contact: Contacts
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let avatar = contact.avatar {
                Image(avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ConstantsSize.avatarSize, height: ConstantsSize.avatarSize)
                    .clipShape(RoundedRectangle(cornerRadius: ConstantsSize.avatarCornerRadius))
                
            }  else if let initials = contact.initials {
                InitialsViewWidget(initials: initials)
            }
            
        }
    }
}

struct InitialsViewWidget: View {
    let initials: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: ConstantsSize.avatarCornerRadius)
            .fill(Color.purple)
            .frame(width: ConstantsSize.avatarSize, height: ConstantsSize.avatarSize)
            .overlay(
                Text(initials)
            )
    }
}

struct WidgetDeepLinkInteractiveWidget: Widget {
    let kind: String = "DeepLinkExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetDeepLinkProvider()) { entry in
            WidgetDeepLinkEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("DeepLink Widget")
        .description("DeepLink Widget")
    }
}

private struct ConstantsSize {
    static let avatarSize: CGFloat = 30
    static let avatarCornerRadius: CGFloat = 10
}
