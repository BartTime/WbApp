import Foundation

struct Country: Identifiable {
    let id = UUID()
    let name: String
    let flagImageName: String
    let code: String
    let regex: String
    let phonecode: String
    
    static func getCountries() -> [Country] {
        return [
            Country(name: "Russia", flagImageName: "flag_russia", code: "+7", regex: "^\\d{3} \\d{3}-\\d{2}-\\d{2}$", phonecode: "000 000-00-00"),
            Country(name: "Armenia", flagImageName: "flag_armenia", code: "+374", regex:"^\\d{2} \\d{5}$", phonecode: "00 00000"),
            Country(name: "Azerbaijan", flagImageName: "flag_azeibardjan", code: "+994", regex: "^\\d{2} \\d{3}-\\d{4}$", phonecode: "00 000-0000"),
            Country(name: "Belarus", flagImageName: "flag_belarus", code: "+375", regex: "^\\d{9}$", phonecode: "000000000"),
            Country(name: "China", flagImageName: "flag_china", code: "+86", regex: "^\\d{2} \\d{4} \\d{4}$", phonecode: "00 0000 0000"),
            Country(name: "UK", flagImageName: "flag_british", code: "+44", regex: "^\\d{3} \\d{3} \\d{4}$", phonecode: "000 000 0000"),
            Country(name: "Kyrgyzstan", flagImageName: "flag_kyrgyzstan", code: "+996", regex: "^\\d{3} \\d{2}-\\d{2}-\\d{2}$", phonecode: "000 00-00-00"),
            Country(name: "Kazakhstan", flagImageName: "flag_kazakhstan", code: "+7", regex: "^\\d{3} \\d{3} \\d{2} \\d{2}$", phonecode: "000 000 00 00"),
            Country(name: "USA", flagImageName: "flag_usa", code: "+1", regex: "^\\d{3} \\d{3} \\d{4}$", phonecode: "000 000 0000"),
            Country(name: "Uzbekistan", flagImageName: "flag_uzbekistan", code: "+998", regex: "^\\d{2} \\d{3} \\d{2} \\d{2}$", phonecode: "00 000 00 00"),
            Country(name: "Turkey", flagImageName: "flag_turkey", code: "+90", regex: "^\\d{3} \\d{3} \\d{4}$", phonecode: "000 000 0000"),
            Country(name: "Georgia", flagImageName: "flag_georgia", code: "+995", regex: "", phonecode: "000 000 000"),
            Country(name: "South Korea", flagImageName: "flag_south_korea", code: "+82", regex: "^\\d{2} \\d{3} \\d{2} \\d{2}$", phonecode: "00 000 00 00"),
            Country(name: "UAE", flagImageName: "flag_uae", code: "+971", regex: "^\\d \\d{7}$", phonecode: "0 0000000")
        ]
    }
}
