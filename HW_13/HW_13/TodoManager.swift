import Foundation

class TodoManager {
    static let shared = TodoManager()
    
    private(set) var todos: [TodoItem] = []
    private var observable = Observable<[TodoItem]>()
    
    private init() {}
    
    func add(todo: TodoItem) {
        todos.append(todo)
        notifyObservers()
    }
    
    func remove(todo: TodoItem) {
        todos.removeAll { $0.id == todo.id }
        notifyObservers()
    }
    
    func toggleCompletion(for todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isComleted.toggle()
            notifyObservers()
        }
    }
    
    func addObserver<O: Observer>(_ observer: O) where O.ObservedType == [TodoItem] {
        observable.addObserver(observer)
    }
    
    func removeObserver<O: Observer>(_ observer: O) where O.ObservedType == [TodoItem] {
        observable.removeObserver(observer)
    }
    
    private func notifyObservers() {
        observable.notifyObservers(with: todos)
    }
}
