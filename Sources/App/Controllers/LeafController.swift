import HTTP
import Vapor

final class LeafController: ResourceRepresentable {
    
    let view: ViewRenderer
    
    init(view: ViewRenderer, hash: HashProtocol) {
        self.view = view
    }
    
    func makeResource() -> Resource<Empty> {
        return Resource(
            index: index
        )
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        
        let contents = [
            Node(["name": Node.string("hoge")]),
            Node(["name": Node.string("hoge")]),
            Node(["name": Node.string("foo")])
        ]
        
        let context: [String: Node] = [
            "title": .string("Leaf-Test"),
            "isLoggedIn": .bool(false),
            "rhs": .number(0),
            "lhs": .number(0),
            "contents": .array(contents)
        ]
        
        return try view.make("index.leaf", context)
    }
}
