@_exported import Vapor
import AuthProvider
import FluentProvider
import HTTP
import MySQLProvider
import LeafProvider
import RedisProvider
import Sessions

extension Droplet {
    public func setup() throws {
        try collection(Routes(view: view, hash: hash))
    }
}

extension Config {
    public func setup() throws {
    
        let redisCache = try RedisCache(config: self)
        let sessions = CacheSessions(redisCache)
        
        addConfigurable(middleware: { _ in SessionsMiddleware(sessions) }, name: "redis-sessions")
        addConfigurable(middleware: { _ in PersistMiddleware(User.self) }, name: "persist-user")
        
        try addProvider(FluentProvider.Provider.self)
        try addProvider(MySQLProvider.Provider.self)
        try addProvider(LeafProvider.Provider.self)
        
        preparations += [
            User.self
        ]
    }
}
