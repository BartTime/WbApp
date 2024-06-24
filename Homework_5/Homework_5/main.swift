import Foundation

class Passport {
    var series: String
    var number: String
    var issueDate: Date
    weak var person: Person?
    
    init(series: String, number: String, issueDate: Date, person: Person? = nil) {
        self.series = series
        self.number = number
        self.issueDate = issueDate
        self.person = person
        print("Паспорт \(series) \(number) был создан")
    }
    
    deinit {
        print("Паспорт \(series) \(number) был удален из памяти")
    }
}

class Person {
    var fulName: String
    var age: Int
    var passport: Passport?
    
    init(fullName: String, age: Int, passportSeries: String, passportNumber: String, passportIssueDate: Date) {
        self.fulName = fullName
        self.age = age
        self.passport = Passport(series: passportSeries, number: passportNumber, issueDate: passportIssueDate, person: self)
        print("\(fullName) был создан")
    }
    
    deinit {
        print("\(fulName) был удален из памяти")
    }
}

var people: [Person] = []

func displayMenu() {
    print("""
    Выберите действие:
    1. Создать нового человека
    2. Показать всех людей
    3. Удалить человека
    4. Выйти
    """)
}

func createPerson() {
    print("Введите ФИО:")
    guard let fullName = readLine(), !fullName.isEmpty else {
        print("Некорректное ФИО.")
        return
    }
    
    print("Введите возраст:")
    guard let ageInput = readLine(), let age = Int(ageInput), age > 0 else {
        print("Некорректный возраст.")
        return
    }
    
    print("Введите серию паспорта:")
    guard let passportSeries = readLine(), !passportSeries.isEmpty else {
        print("Некорректная серия паспорта.")
        return
    }
    
    print("Введите номер паспорта:")
    guard let passportNumber = readLine(), !passportNumber.isEmpty else {
        print("Некорректный номер паспорта.")
        return
    }
    
    print("Введите дату выдачи паспорта (в формате yyyy-MM-dd):")
    guard let passportIssueDateString = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines),
          !passportIssueDateString.isEmpty else {
        print("Дата не введена или содержит только пробелы.")
        return
    }
    
    guard let passportIssueDate = dateFormatter.date(from: passportIssueDateString) else {
        print("Некорректная дата: \(passportIssueDateString)")
        return
    }
    
    let person = Person(fullName: fullName, age: age, passportSeries: passportSeries, passportNumber: passportNumber, passportIssueDate: passportIssueDate)
    people.append(person)
    print("Человек успешно создан.")
}

func showAllPeople() {
    if people.isEmpty {
        print("Нет созданных людей.")
    } else {
        for (index, person) in people.enumerated() {
            print("\(index + 1). \(person.fulName), возраст: \(person.age), паспорт: \(person.passport!.series) \(person.passport!.number), дата выдачи: \(dateFormatter.string(from: person.passport!.issueDate)))")
        }
    }
}

func deletePerson() {
    showAllPeople()
    print("Введите номер человека для удаления:")
    guard let indexInput = readLine(), let index = Int(indexInput), index > 0, index <= people.count else {
        print("Некорректный номер.")
        return
    }
    
    people.remove(at: index - 1)
    print("Человек удален.")
}

func main() {
    var shouldContinue = true
    
    while shouldContinue {
        displayMenu()
        guard let choice = readLine() else { continue }
        
        switch choice {
        case "1":
            createPerson()
        case "2":
            showAllPeople()
        case "3":
            deletePerson()
        case "4":
            shouldContinue = false
        default:
            print("Некорректный выбор.")
        }
    }
    
    print("Программа завершена.")
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}()

main()
