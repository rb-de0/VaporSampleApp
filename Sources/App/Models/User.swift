import Authentication
import AuthProvider
import FluentProvider
import Vapor

final class User: Model {
    
    let storage = Storage()
    let username: String
    let password: String
    
    init(usernamePassWord: Password) {
        username = usernamePassWord.username
        password = usernamePassWord.password
    }
    
    required init(row: Row) throws {
        username = try row.get("username")
        password = try row.get("password")
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("username", username)
        try row.set("password", password)
        return row
    }
    
    func makeJSON() throws -> JSON {
        return JSON(["username": .string(username), "password": .string(password)])
    }
}

// MARK: - Preparation
extension User: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        
        try database.create(self) { builder in
            builder.id()
            builder.string("username")
            builder.string("password")
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}

// MARK: - Auth
extension Request {
    
    func user() throws -> User {
        return try auth.assertAuthenticated()
    }
}

// MARK: - SessionPersistable
extension User: SessionPersistable {}

// MARK: - PasswordAuthenticatable
extension User: PasswordAuthenticatable {
    
    static var usernameKey: String {
        return "username"
    }
}
