import Foundation

extension String {
    func localizableString(_ name: String) -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
