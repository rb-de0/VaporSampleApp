import HTTP
import Vapor

final class CORSController: ResourceRepresentable {
    
    func makeResource() -> Resource<Empty> {
        return Resource(
            index: index,
            store: store
        )
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: ["version": "2.0"])
    }
    
    func store(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: ["version": "2.0"])
    }
}
