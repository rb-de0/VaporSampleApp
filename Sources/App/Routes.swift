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
        
        builder.get("/") { request in
            return try self.view.make("contents.leaf")
        }
        
        builder.get("/auth") { request in
            return try request.user().makeJSON()
        }
    }
}
