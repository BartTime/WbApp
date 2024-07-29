import SwiftUI
import UIKit

class ImageLoader: ObservableObject {
    @Published var imageCache: [String: UIImage] = [:] // Кэш изображений
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache[url] {
            completion(cachedImage)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: imageURL)
                if let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageCache[url] = loadedImage
                        completion(loadedImage)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to load image: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
    
    func fetchRandomImageURL() async -> String? {
        guard let url = URL(string: "https://random.dog/woof.json") else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let dogImageResponse = try JSONDecoder().decode(DogImageResponse.self, from: data)
            return dogImageResponse.url
        } catch {
            print("Failed to fetch image URL: \(error.localizedDescription)")
            return nil
        }
    }
}

struct DogImageResponse: Decodable {
    let url: String
}
