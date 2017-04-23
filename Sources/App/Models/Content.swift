import Authentication
import AuthProvider
import FluentProvider
import Vapor

final class Content: Model, Timestampable, JSONRepresentable {
    
    let storage = Storage()
    let title: String
    let detail: String
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
    
    required init(row: Row) throws {
        title = try row.get("title")
        detail = try row.get("detail")
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("title", title)
        try row.set("detail", detail)
        return row
    }
    
    func makeJSON() throws -> JSON {
        return JSON(["title": .string(title), "detail": .string(detail)])
    }
}

// MARK: - Preparation
extension Content: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        
        try database.create(self) { builder in
            builder.id()
            builder.string("title")
            builder.string("detail")
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
