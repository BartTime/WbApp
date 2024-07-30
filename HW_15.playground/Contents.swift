import Foundation

class SomeTask {
    let id: UUID
    let data: String
    
    init(data: String) {
        self.id = UUID()
        self.data = data
    }
}

class Client {
    let id: UUID
    var server: Server?
    
    init() {
        self.id = UUID()
    }
    
    func connect(to server: Server) async {
        self.server = server
        await server.registerClient(self)
    }
}

actor Server {
    private var clients = [UUID: Client]()
    private var taskQueue = [SomeTask]()
    private var taskResult = [UUID: String]()
    
    func registerClient(_ client: Client) async {
        clients[client.id] = client
        print("Client \(client.id) connected")
        await distributeTasks()
    }
    
    func submitTask(_ task: SomeTask) async {
        taskQueue.append(task)
        await distributeTasks()
    }
    
    func distributeTasks() async {
        while !taskQueue.isEmpty {
            for client in clients.values {
                if let task = taskQueue.first {
                    taskQueue.removeFirst()
                    let result = await processTask(task)
                    await submitResult(client: client, task: task, result: result)
                }
            }
        }
    }
    
    private func processTask(_ task: SomeTask) async -> String {
        return "Processed \(task.data)"
    }
    
    func submitResult(client: Client, task: SomeTask, result: String) async {
        print("Server received result for task \(task.id) from client \(client.id): \(result)")
        taskResult[task.id] = result
    }
}

class TaskManager {
    let server: Server
    
    init(server: Server) {
        self.server = server
    }
    
    func createAndSubmitTask(data: String) async {
        let task = SomeTask(data: data)
        await server.submitTask(task)
    }
}



let server = Server()
let client1 = Client()
let client2 = Client()

Task {
    await client1.connect(to: server)
    await client2.connect(to: server)
    
    let taskManager = TaskManager(server: server)
    await taskManager.createAndSubmitTask(data: "Task data 1")
    await taskManager.createAndSubmitTask(data: "Task data 2")
}
