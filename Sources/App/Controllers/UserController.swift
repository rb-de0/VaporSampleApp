import Authentication
import HTTP
import Vapor

final class UserController: ResourceRepresentable {
    
    let hash: HashProtocol
    
    init(hash: HashProtocol) {
        self.hash = hash
    }
    
    func makeResource() -> Resource<User> {
        return Resource(
            store: store
        )
    }
    
    func store(request: Request) throws -> ResponseRepresentable {
        let credential = try request.userNamePassword(hash: hash)
        try User(usernamePassWord: credential).save()
        return Response(foundRedirect: "/login")
    }
}

extension Request {
    
    func userNamePassword(hash: HashProtocol) throws -> Password {
        
        guard let username = data["username"]?.string,
            let password = data["password"]?.string,
            let hashedPass = try? hash.make(password).makeString() else {
                throw Abort.badRequest
        }
        
        return Password(username: username, password: hashedPass)
    }
}
