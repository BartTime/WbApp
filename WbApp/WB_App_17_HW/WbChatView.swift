import SwiftUI
import ExyteChat
import ExyteMediaPicker
import Foundation

@MainActor
class MediaViewModel: ObservableObject {
    @Published var mediaItems: [MediaItem] = []
    
    struct MediaItem: Identifiable {
        let id = UUID()
        let media: Media
        var image: UIImage?
    }
    
    func loadImages(from mediaArray: [Media]) async {
        var items: [MediaItem] = []
        for media in mediaArray {
            if media.type == .image {
                
                    guard let data = await media.getData() else { return }
                    if let image = UIImage(data: data) {
                        items.append(MediaItem(media: media, image: image))
                    }
                
            }
        }
        self.mediaItems = items
    }
    
    func removeImage(id: UUID) {
        mediaItems.removeAll { $0.id == id }
    }
}

struct WbChatView: View {
    @EnvironmentObject var appData: AppData
    @State var medias = [Media]()
    @StateObject private var viewModel = MediaViewModel()
    @State var messages: [Message] = [
        Message(id: "123", user: User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: true), status: .read, createdAt: Date(), text: "Годзилла топчик, позже запишу голосом"),
        Message(id: "124", user: User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: false), createdAt: Date(), text: "Годзилла топчик, позже запишу голосом"),
        Message(id: "125", user:  User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: false), createdAt: Date(), text: "Кайфы, как тебе", recording: nil, replyMessage: ReplyMessage(id: "124", user: User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: true), createdAt: Date(), text: "Купил годзиллу")),
        Message(id: "126", user:  User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: true), createdAt: Date(), text: "Кайфы, как тебе?", recording: nil, replyMessage: ReplyMessage(id: "124", user: User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: true), createdAt: Date(), text: "Купил годзиллу")),
        Message(id: "128", user: User(id: "111", name: "Vasya", avatarURL: nil, isCurrentUser: false), createdAt: Date(), text: "Смотри че генерится", attachments: [Attachment(id: "1", url: URL(string: "ImagePlaceholder")!, type: .image), Attachment(id: "2", url: URL(string: "ImagePlaceholder")!, type: .image)])
    ]
    
    @State var isPresent = false
    var contact: Contacts
    
    var body: some View {
        Group {
            ChatView(messages: messages) { draft in
                
            } messageBuilder: { message, positionInUserGroup, positionInCommentsGroup, showContextMenuClosure, messageActionClosure, showAttachmentClosure in
                MessageView(message: message)
                    .padding(.bottom, Constants.Layout.messagePaddingBottom)
            } inputViewBuilder: { textBinding, attachments, inputViewState, inputViewStyle, inputViewActionClosure, dismissKeyboardClosure in
                Group {
                    switch inputViewStyle {
                    case .message:
                        inputView(textBinding: textBinding)
                    case .signature:
                        EmptyView()
                    }
                }
                .background(Color("barsBackground"))
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                trailingButtons
            }
        }
        .chatTheme(ChatTheme(colors: .init(mainBackground: Color("ChatBackground"))))
        .toolbarBackground(Color("barsBackground"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $isPresent) {
            MediaPicker(isPresented: $isPresent, onChange: { medias = $0 })
        }
        .onChange(of: isPresent) { newValue in
            if !newValue {
                Task {
                    await viewModel.loadImages(from: medias)
                }
            }
        }
    }
    
    private var backButton: some View {
        Button {
            appData.removeContactFromNavStack(contact: contact)
        } label: {
            HStack {
                Image("chevron")
                    .resizable()
                    .modifier(NavigationIconStyleNav())
                    .padding(.leading, Constants.Layout.iconPadding)
                Text(contact.name ?? "No name")
                    .modifier(Subheading1())
                    .foregroundColor(.primary)
            }
        }
    }
    
    private var trailingButtons: some View {
        HStack(spacing: Constants.Layout.trailingSpacing) {
            Button {
                print()
            } label: {
                Image("loop")
                    .resizable()
                    .modifier(NavigationIconStyleNav())
            }
            Button {
                print()
            } label: {
                Image("Icon")
                    .resizable()
                    .modifier(NavigationIconStyleNav())
            }
        }
    }
    
    private func inputView(textBinding: Binding<String>) -> some View {
        VStack {
            if !viewModel.mediaItems.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.mediaItems) { item in
                            if let image = item.image {
                                ZStack(alignment: .topTrailing) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 50, maxHeight: 50)
                                        .padding()
                                    Button(action: {
                                        viewModel.removeImage(id: item.id)
                                    }) {
                                        Image(systemName: "trash")
                                            .frame(width: 20, height: 20, alignment: .topTrailing)
                                            .background(Color.black.opacity(0.7))
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                            .padding(10)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            HStack {
                Button {
                    isPresent.toggle()
                } label: {
                    Image("plus")
                        .resizable()
                        .modifier(ButtonImageStyle())
                }
                TextFieldInput(searchText: textBinding, showGlass: false, defaultText: "Message")
                Button {
                    print("send")
                } label: {
                    Image("pipeline")
                        .resizable()
                        .modifier(ButtonImageStylePurple())
                }
            }
            .padding()
        }
    }
}

private struct Constants {
    struct Layout {
        static let iconPadding: CGFloat = 8
        static let messagePaddingBottom: CGFloat = 12
        static let trailingSpacing: CGFloat = 10
    }
}
