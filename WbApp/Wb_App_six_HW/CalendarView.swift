import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var selectedLocale = Locale(identifier: "ru_RU")
    
    let flags = ["🇷🇺", "🇺🇸", "🇫🇷", "🇩🇪", "🇨🇳"]
    let locales = ["ru_RU", "en_US", "fr_FR", "de_DE", "zh_Hans_CN"]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(LocalizedStringKey("title for change language"))
                .font(.system(size: 20, weight: .bold))
            DatePicker("Выберите дату", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .padding()
            
            Picker("Выберите язык", selection: $selectedLocale) {
                ForEach(0..<flags.count) { index in
                    Text(self.flags[index])
                        .tag(Locale(identifier: self.locales[index]))
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            let dayNames = localizedDayNames(for: selectedLocale)
            List {
                Section {
                    Text("\(dayNames[0]): \(date: Calendar.current.date(byAdding: .day, value: -2, to: selectedDate)!, locale: selectedLocale, style: .medium)")
                    Text("\(dayNames[1]): \(date: Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!, locale: selectedLocale, style: .medium)")
                    Text("\(dayNames[2]): \(date: selectedDate, locale: selectedLocale, style: .medium)").bold()
                    Text("\(dayNames[3]): \(date: Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!, locale: selectedLocale, style: .medium)")
                    Text("\(dayNames[4]): \(date: Calendar.current.date(byAdding: .day, value: 2, to: selectedDate)!, locale: selectedLocale, style: .medium)")
                }
                
                Section {
                    Text("\(dayNames[0]): \(spellOut: Calendar.current.date(byAdding: .day, value: -2, to: selectedDate)!, locale: selectedLocale)")
                    Text("\(dayNames[1]): \(spellOut: Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!, locale: selectedLocale)")
                    Text("\(dayNames[2]): \(spellOut: selectedDate, locale: selectedLocale)").bold()
                    Text("\(dayNames[3]): \(spellOut: Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!, locale: selectedLocale)")
                    Text("\(dayNames[4]): \(spellOut: Calendar.current.date(byAdding: .day, value: 2, to: selectedDate)!, locale: selectedLocale)")
                }
            }
            Spacer()
        }
    }
    
    func localizedString(for key: String) -> String {
        return LocalizationManager.shared.localizedString(forKey: key)
    }
}

private func localizedDayNames(for locale: Locale) -> [String] {
    let languageCode: String
    
    switch locale.identifier {
    case "de_DE":
        languageCode = "de"
    case "en_US":
        languageCode = "en"
    case "fr_FR":
        languageCode = "fr"
    case "zh_CN":
        languageCode = "zh-Hans"
    case "ru_RU":
        languageCode = "ru"
    default:
        languageCode = "ru"
    }

    LocalizationManager.shared.setAppLanguage(languageCode)

    let names = [
        LocalizationManager.shared.localizedString(forKey: "Day before yesterday"),
        LocalizationManager.shared.localizedString(forKey: "Yesterday"),
        LocalizationManager.shared.localizedString(forKey: "Today"),
        LocalizationManager.shared.localizedString(forKey: "Tomorrow"),
        LocalizationManager.shared.localizedString(forKey: "Day after tomorrow")
    ]

    return names
}

class LocalizationManager {
    static let shared = LocalizationManager()
    private var currentLanguage: String = Locale.preferredLanguages.first ?? "ru"

    func setAppLanguage(_ language: String) {
        currentLanguage = language
    }

    func localizedString(forKey key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, comment: "")
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(spellOut date: Date, locale: Locale) {
        let calendar = Calendar.current

        let monthFormatter = DateFormatter()
        monthFormatter.locale = locale
        monthFormatter.dateFormat = "MMMM"

        let day = calendar.component(.day, from: date)
        let month = monthFormatter.string(from: date)
        let year = calendar.component(.year, from: date)

        let numberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        numberFormatter.numberStyle = .spellOut
        

        if let dayString = numberFormatter.string(from: NSNumber(value: day)),
           let yearString = numberFormatter.string(from: NSNumber(value: year)){
            appendLiteral("\(dayString.capitalized); \(month); \(yearString.capitalized)")
        } else {
            appendLiteral("\(day) \(month)")
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(date: Date, locale: Locale, style: DateFormatter.Style) {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = style
        let dateString = formatter.string(from: date)
        appendLiteral(dateString)
    }
}

#Preview {
    CalendarView()
}
