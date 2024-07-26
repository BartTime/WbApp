import Foundation

protocol Observer: AnyObject {
    associatedtype ObservedType
    func update(with value: ObservedType)
}

class Observable<T> {
    private var observers = [ObserverWrapper<T>]()
    
    func addObserver<O: Observer>(_ observer: O) where O.ObservedType == T {
        observers.append(ObserverWrapper(observer: observer))
    }
    
    func removeObserver<O: Observer>(_ observer: O) where O.ObservedType == T {
        observers.removeAll { $0.observer === observer }
    }
    
    func notifyObservers(with value: T) {
        for observer in observers {
            observer.update(value)
        }
    }
    
    private class ObserverWrapper<T> {
        weak var observer: AnyObject?
        let update: (T) -> Void
        
        init<O: Observer>(observer: O) where O.ObservedType == T {
            self.observer = observer
            self.update = observer.update
        }
    }
}
