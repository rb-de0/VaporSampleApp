import Vapor
import HTTP

struct Routes: RouteCollection {
    
    let view: ViewRenderer
    let hash: HashProtocol
    
    func build(_ builder: RouteBuilder) throws {
        
        builder.resource("/users", UserController(hash: hash))
        builder.resource("/login", LoginController(view: view, hash: hash))
        builder.resource("/leaf", LeafController(view: view, hash: hash))
        builder.resource("/cors", CORSController())
        
        builder.get("/") { _ in
            return try self.view.make("contents.leaf")
        }
        
        builder.get("/leaf") { _ in
            
            let contents: [Node] = [
                ["name": "hoge"],
                ["name": "bar"],
                ["name": "foo"]
            ]
            
            let context: [String: Node] = [
                "title": "LeafTest",
                "rhs": 0,
                "lhs": 0,
                "isLoggedIn": true,
                "contents": .array(contents)
            ]
            
            return try self.view.make("index.leaf", context)
        }
        
        builder.get("/auth") { request in
            return try request.user().makeJSON()
        }
    }
}
