import Foundation

protocol AccountInfo {
    func displayAccountInfo()
}

// Базовый класс Account
class Account: AccountInfo {
    let accountNumber: String
    let owner: String
    private(set) var balance: Double
    var transactionHistory: [String]
    
    init(accountNumber: String, owner: String, initialBalance: Double = 0.0) {
        self.accountNumber = accountNumber
        self.owner = owner
        self.balance = initialBalance
        self.transactionHistory = ["Initial balance: \(initialBalance)"]
    }
    
    func deposit(amount: Double) {
        guard amount > 0 else {
            print("Сумма пополнения должна быть положительной.")
            return
        }
        
        balance += amount
        transactionHistory.append("Deposit: \(amount)")
        print("Пополнение: \(amount) на счет \(accountNumber). Новый баланс: \(balance).")
    }
    
    func withdraw(amount: Double) -> Bool {
        guard amount > 0 else {
            print("Сумма снятия должна быть положительной.")
            return false
        }
        
        guard amount <= balance else {
            print("Недостаточно средств на счете \(accountNumber).")
            return false
        }
        
        balance -= amount
        transactionHistory.append("Withdraw: \(amount)")
        print("Снятие: \(amount) со счета \(accountNumber). Новый баланс: \(balance).")
        return true
    }
    
    func displayAccountInfo() {
        print("Счет \(accountNumber) | Владелец: \(owner) | Баланс: \(balance)")
        print("История операций: \(transactionHistory.joined(separator: ", "))")
    }
}

// Класс для сберегательного счета с минимальным балансом
class SavingsAccount: Account {
    let minimumBalance: Double
    
    init(accountNumber: String, owner: String, initialBalance: Double = 0.0, minimumBalance: Double = 0.0) {
        self.minimumBalance = minimumBalance
        super.init(accountNumber: accountNumber, owner: owner, initialBalance: initialBalance)
    }
    
    override func withdraw(amount: Double) -> Bool {
        guard balance - amount >= minimumBalance else {
            print("Снятие невозможно. Баланс счета не может быть ниже минимального уровня \(minimumBalance).")
            return false
        }
        return super.withdraw(amount: amount)
    }
    
    override func displayAccountInfo() {
        print("Сберегательный \(super.accountNumber) | Владелец: \(super.owner) | Баланс: \(super.balance) | Минимальный баланс: \(minimumBalance)")
        print("История операций: \(transactionHistory.joined(separator: ", "))")
    }
}

// Класс для расчетного счета с комиссией за превышение лимита операций
class CheckingAccount: Account {
    let transactionLimit: Int
    let transactionFee: Double
    private var transactionCount: Int
    
    init(accountNumber: String, owner: String, initialBalance: Double = 0.0, transactionLimit: Int = 10, transactionFee: Double = 2.0) {
        self.transactionLimit = transactionLimit
        self.transactionFee = transactionFee
        self.transactionCount = 0
        super.init(accountNumber: accountNumber, owner: owner, initialBalance: initialBalance)
    }
    
    override func deposit(amount: Double) {
        super.deposit(amount: amount)
        applyTransactionFeeIfNeeded()
    }
    
    override func withdraw(amount: Double) -> Bool {
        let success = super.withdraw(amount: amount)
        if success {
            applyTransactionFeeIfNeeded()
        }
        return success
    }
    
    private func applyTransactionFeeIfNeeded() {
        transactionCount += 1
        if transactionCount > transactionLimit {
            super.withdraw(amount: transactionFee)
            print("Применена комиссия за превышение лимита операций: \(transactionFee). Новый баланс: \(super.balance).")
        }
    }
    
    override func displayAccountInfo() {
        print("Расчетный \(super.accountNumber) | Владелец: \(super.owner) | Баланс: \(super.balance) | Лимит операций: \(transactionLimit) | Комиссия: \(transactionFee)")
        print("История операций: \(transactionHistory.joined(separator: ", "))")
    }
}

// Класс Bank для управления счетами
class Bank {
    private var accounts: [String: Account] = [:]
    
    func addAccount(account: Account) {
        accounts[account.accountNumber] = account
        print("Добавлен счет \(account.accountNumber) с начальным балансом \(account.balance).")
    }
    
    func removeAccount(accountNumber: String) {
        if let removedAccount = accounts.removeValue(forKey: accountNumber) {
            print("Удален счет \(accountNumber) | Владелец: \(removedAccount.owner) | Баланс: \(removedAccount.balance)")
        } else {
            print("Счет с номером \(accountNumber) не найден.")
        }
    }
    
    func findAccount(byNumber accountNumber: String) -> Account? {
        return accounts[accountNumber]
    }
    
    func findAccounts(byOwner owner: String) -> [Account] {
        return accounts.values.filter { $0.owner == owner }
    }
    
    func findAccounts(withBalanceAbove amount: Double) -> [Account] {
        return accounts.values.filter { $0.balance > amount }
    }
    
    func transfer(amount: Double, from fromAccountNumber: String, to toAccountNumber: String) {
        guard let fromAccount = findAccount(byNumber: fromAccountNumber),
              let toAccount = findAccount(byNumber: toAccountNumber) else {
            print("Один или оба счета не найдены.")
            return
        }
        
        if fromAccount.withdraw(amount: amount) {
            toAccount.deposit(amount: amount)
            print("Перевод: \(amount) со счета \(fromAccountNumber) на счет \(toAccountNumber).")
        }
    }
    
    func printAccounts() {
        for account in accounts.values {
            account.displayAccountInfo()
            print("---------------------")
        }
    }
}

class BankingSystem {
    private let bank = Bank()
    
    func start() {
        var shouldContinue = true
        
        while shouldContinue {
            print("""
                  \nМеню:
                  1. Создать счет
                  2. Пополнить счет
                  3. Снять средства
                  4. Перевести средства
                  5. Показать состояние всех счетов
                  6. Удалить счет
                  7. Найти счета по владельцу
                  8. Найти счета с балансом выше указанного
                  9. Выйти
                  """)
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    createAccount()
                case "2":
                    depositToAccount()
                case "3":
                    withdrawFromAccount()
                case "4":
                    transferFunds()
                case "5":
                    showAllAccounts()
                case "6":
                    removeAccount()
                case "7":
                    findAccountsByOwner()
                case "8":
                    findAccountsByBalance()
                case "9":
                    shouldContinue = false
                    print("Выход из системы.")
                default:
                    print("Неверный выбор. Попробуйте снова.")
                }
            }
        }
    }
    
    private func createAccount() {
        print("Выберите тип счета: 1 - Сберегательный, 2 - Расчетный")
        guard let accountType = readLine(), accountType == "1" || accountType == "2" else {
            print("Неверный выбор типа счета.")
            return
        }
        
        print("Введите номер счета:")
        guard let accountNumber = readLine() else { return }
        
        print("Введите имя владельца счета:")
        guard let owner = readLine() else { return }
        
        print("Введите начальный баланс:")
        guard let initialBalanceStr = readLine(), let initialBalance = Double(initialBalanceStr) else {
            print("Неверное значение начального баланса.")
            return
        }
        
        if accountType == "1" {
            print("Введите минимальный баланс:")
            guard let minBalanceStr = readLine(), let minBalance = Double(minBalanceStr) else {
                print("Неверное значение минимального баланса.")
                return
            }
            let newAccount = SavingsAccount(accountNumber: accountNumber, owner: owner, initialBalance: initialBalance, minimumBalance: minBalance)
            bank.addAccount(account: newAccount)
        } else {
            print("Введите лимит операций:")
            guard let limitStr = readLine(), let limit = Int(limitStr) else {
                print("Неверное значение лимита операций.")
                return
            }
            print("Введите комиссию за превышение лимита операций:")
            guard let feeStr = readLine(), let fee = Double(feeStr) else {
                print("Неверное значение комиссии.")
                return
            }
            let newAccount = CheckingAccount(accountNumber: accountNumber, owner: owner, initialBalance: initialBalance, transactionLimit: limit, transactionFee: fee)
            bank.addAccount(account: newAccount)
        }
    }
    
    private func depositToAccount() {
        print("Введите номер счета для пополнения:")
        guard let accountNumber = readLine(), let account = bank.findAccount(byNumber: accountNumber) else {
            print("Счет не найден.")
            return
        }
        
        print("Введите сумму пополнения:")
        guard let amountStr = readLine(), let amount = Double(amountStr) else {
            print("Неверное значение суммы.")
            return
        }
        
        account.deposit(amount: amount)
    }
    
    private func withdrawFromAccount() {
        print("Введите номер счета для снятия средств:")
        guard let accountNumber = readLine(), let account = bank.findAccount(byNumber: accountNumber) else {
            print("Счет не найден.")
            return
        }
        
        print("Введите сумму снятия:")
        guard let amountStr = readLine(), let amount = Double(amountStr) else {
            print("Неверное значение суммы.")
            return
        }
        
        _ = account.withdraw(amount: amount)
    }
    
    private func transferFunds() {
        print("Введите номер счета отправителя:")
        guard let fromAccountNumber = readLine(), bank.findAccount(byNumber: fromAccountNumber) != nil else {
            print("Счет отправителя не найден.")
            return
        }
        
        print("Введите номер счета получателя:")
        guard let toAccountNumber = readLine(), bank.findAccount(byNumber: toAccountNumber) != nil else {
            print("Счет получателя не найден.")
            return
        }
        
        print("Введите сумму перевода:")
        guard let amountStr = readLine(), let amount = Double(amountStr) else {
            print("Неверное значение суммы.")
            return
        }
        
        bank.transfer(amount: amount, from: fromAccountNumber, to: toAccountNumber)
    }
    
    private func showAllAccounts() {
        bank.printAccounts()
    }
    
    private func removeAccount() {
        print("Введите номер счета для удаления:")
        guard let accountNumber = readLine() else { return }
        bank.removeAccount(accountNumber: accountNumber)
    }
    
    private func findAccountsByOwner() {
        print("Введите имя владельца для поиска:")
        guard let owner = readLine() else { return }
        let accounts = bank.findAccounts(byOwner: owner)
        if accounts.isEmpty {
            print("Счета не найдены.")
        } else {
            for account in accounts {
                account.displayAccountInfo()
                print("---------------------")
            }
        }
    }
    
    private func findAccountsByBalance() {
        print("Введите сумму для поиска счетов с балансом выше этой суммы:")
        guard let amountStr = readLine(), let amount = Double(amountStr) else {
            print("Неверное значение суммы.")
            return
        }
        let accounts = bank.findAccounts(withBalanceAbove: amount)
        if accounts.isEmpty {
            print("Счета не найдены.")
        } else {
            for account in accounts {
                account.displayAccountInfo()
                print("---------------------")
            }
        }
    }
}

let bankingSystem = BankingSystem()
bankingSystem.start()
