import AuthProvider
import FluentProvider
import MySQLProvider
import LeafProvider
import RedisProvider
import Sessions

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [Row.self, JSON.self, Node.self]

        try setupConfiguable()
        try setupProviders()
        try setupPreparations()
    }
    
    private func setupConfiguable() throws {
        let redisCache = try RedisCache(config: self)
        let sessions = CacheSessions(redisCache)
        
        addConfigurable(middleware: { _ in SessionsMiddleware(sessions) }, name: "redis-sessions")
        addConfigurable(middleware: { _ in PersistMiddleware(User.self) }, name: "persist-user")
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(FluentProvider.Provider.self)
        try addProvider(MySQLProvider.Provider.self)
        try addProvider(LeafProvider.Provider.self)
    }
    
    /// Add all models that should have their
    /// schemas prepared before the app boots
    private func setupPreparations() throws {
        let models: [Preparation.Type] = [
            User.self,
            Content.self
        ]
        
        preparations += models

    }
}
