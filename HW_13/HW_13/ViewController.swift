import UIKit

class TodoListViewController: UIViewController, Observer {
    func update(with value: [TodoItem]) {
        self.todos = value
        tableView.reloadData()
    }
    
    typealias ObservedType = [TodoItem]
    
    private let tableView = UITableView()
    private var todos: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        TodoManager.shared.addObserver(self)
        loadTodos()
    }
    
    private func loadTodos() {
        todos = TodoManager.shared.todos
    }
    
    private func setupView() {
        view.addSubview(tableView)
        title = "Todo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    }
    
    @objc private func addTodo() {
        let addTodoVC = AddTodoViewController()
        addTodoVC.modalPresentationStyle = .formSheet
        present(addTodoVC, animated: true, completion: nil)
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as! TodoCell
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        TodoManager.shared.toggleCompletion(for: todo)
    }
}
