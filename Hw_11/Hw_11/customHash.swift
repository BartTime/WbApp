import Foundation

func customHash(of string: String) -> Int {
    var hash = 0
    for char in string.unicodeScalars {
        hash = 31 &* hash &+ Int(char.value)
    }
    return hash
}
