import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let todoListVC = TodoListViewController()
        navigationController.setViewControllers([todoListVC], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
