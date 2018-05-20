import Vapor
import Routing

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return SayHello(content: "Hello World")
    }
    //%%%%%%%%%%%%%%%%%%%%%%%%%%S1V5 test%%%%%%%%%%%%%%%%%%%%%%%%
    router.get("date"){ req -> String in
        let date = Date()
        return date.description
    }
    
    router.get(Int.parameter) {req -> Int in
        let number = try req.parameters.next(Int.self)
        return number
    }
    
    router.post(UserData.self, at: "user-info") { (req, info) -> String in
        return "Hello \(info.name), you are \(info.age)"
    }
    //%%%%%%%%%%%%%%%%%%%%%%%%%%S1V5 test%%%%%%%%%%%%%%%%%%%%%%%%
    
    router.get("greet", use: HelloController().greet)
    
    router.post("login") { (req) -> Future<HTTPStatus> in
        return try req.content.decode(LoginRequest.self).map(to: HTTPStatus.self) { loginRequest in
            print(loginRequest.email) // user@vapor.codes
            print(loginRequest.password) // don't look!
            return .ok
        }
    }
    
    router.get("user") { (req) -> User in
        return User(
            name: "Vapor User",
            email: "user@vapor.codes")
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct SayHello: Content{
    var content: String
}

struct UserData: Content {
    var name: String
    var age: Int
}

struct LoginRequest: Content{
    var email: String
    var password: String
}

struct User: Content{
    var name: String
    var email: String
}
