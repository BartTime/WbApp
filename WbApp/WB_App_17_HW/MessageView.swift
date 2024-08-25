import SwiftUI
import ExyteChat

struct MessageView: View {
    var message: Message
    
    var body: some View {
        let current = message.user.isCurrentUser
        
        HStack {
            if current {
                Spacer()
            }
            VStack(alignment: current ? .trailing : .leading) {
                if !message.attachments.isEmpty {
                    ForEach(message.attachments) { attach in
                        Image(attach.full.absoluteString)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: Constants.maxWidth)
                        
                            .padding(.horizontal, Constants.paddingHorizontal)
                            .padding(.top, Constants.paddingVertical)
                    }
                }
                
                if let reply = message.replyMessage {
                    ReplyMessageView(reply: reply, current: message.user.isCurrentUser)
                        .padding(.top, Constants.paddingVertical)
                        .padding(current ? .trailing : .leading, Constants.paddingHorizontal)
                }
                
                Text(message.text)
                    .frame(maxWidth: Constants.maxWidth, alignment: current ? .trailing : .leading)
                    .modifier(BodyText2())
                    .foregroundColor(current ? Color("textColorMessage") : Color("TextColor"))
                    .padding(Constants.paddingVertical)
                
                
                HStack {
                    Text(formatDate(date: message.createdAt, with: Constants.dateFormat))
                        .modifier(Metadata2())
                        .foregroundColor(current ? Color("textColorMessage") : (Color("TextColor")))
                    if message.status == .read && current {
                        Text("Прочитано")
                            .modifier(Metadata2())
                            .foregroundColor(Color("textColorMessage"))
                    }
                }
                .padding(.horizontal, Constants.paddingHorizontal)
                .padding(.bottom, Constants.paddingHorizontal)
            }
            .background(current ? Color("MessageBackground") : Color("messageBackgroundAnotherUser"))
            .clipShape(CustomCorners(corners: current ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight], radius: Constants.cornerRadius))
            .padding(current ? .trailing : .leading)
            
            if !current {
                Spacer()
            }
        }
    }
}

struct ReplyMessageView: View {
    var reply: ReplyMessage
    var current: Bool
    
    var body: some View {
        ZStack() {
            VStack(alignment: current ? .trailing : .leading, spacing: Constants.paddingReply) {
                Text(reply.user.name )
                    .modifier(Metadata3())
                    .foregroundStyle(current ? Color("textColorMessage") : Color("textColorReply"))
                    .frame(maxWidth: Constants.replyMaxWidth, alignment: current ? .trailing : .leading)
                
                Text(reply.text)
                    .modifier(BodyText2())
                    .foregroundStyle(current ? Color("textColorMessage") : .primary)
                    .frame(maxWidth: Constants.replyMaxWidth, alignment: current ? .trailing : .leading)
            }
            .frame(maxWidth: Constants.replyMaxWidth)
            .padding(8)
            .background(current ? Color("replyCurrentBackground") : Color("messageBackgroundReply"))
            .clipShape(CustomCorners(corners: current ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight], radius: Constants.replyCornerRadius))
            .padding(current ? .trailing : .leading, Constants.paddingReply)
        }
        .background(current ? Color("messageBackgroundReply") :Color("textColorReply"))
        .clipShape(CustomCorners(corners: [.topLeft, .bottomLeft, .bottomRight, .topRight], radius: Constants.replyCornerRadius))
    }
}

struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    init(corners: [UIRectCorner], radius: CGFloat) {
        self.corners = []
        for corner in corners {
            self.corners.insert(corner)
        }
        self.radius = radius
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

private struct Constants {
    static let maxWidth: CGFloat = 282
    static let paddingHorizontal: CGFloat = 10
    static let paddingVertical: CGFloat = 10
    static let paddingReply: CGFloat = 4
    static let cornerRadius: CGFloat = 16
    static let replyCornerRadius: CGFloat = 6
    static let replyMaxWidth: CGFloat = 228
    static let dateFormat = "HH:mm"
}

#Preview {
    MessageView(message: Message(id: "128", user: User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: true), createdAt: Date(), text: "Смотри че генерится", attachments: [Attachment(id: "1", url: URL(string: "ImagePlaceholder")!, type: .image), Attachment(id: "2", url: URL(string: "ImagePlaceholder")!, type: .image)]))
}
