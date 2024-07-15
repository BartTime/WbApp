import Foundation

struct VerificationInfo: Sequence, Equatable {
    var code: String
    var phoneNumber: String
    
    func isValidCode(_ inputCode: String) -> Bool {
        return inputCode == code
    }
    
    func makeIterator() -> AnyIterator<String> {
        var elements = [code, phoneNumber].makeIterator()
        return AnyIterator {
            elements.next()
        }
    }
    
    static func == (lhs: VerificationInfo, rhs: String) -> Bool {
        return lhs.code == rhs
    }
}
