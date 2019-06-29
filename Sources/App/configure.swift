import Vapor
import ASCApi
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try services.register(LeafProvider())
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    var contentConfig = ContentConfig.default()
    /// Register JSON encoder and content config
    contentConfig.use(encoder: JSONEncoder(), for: .jsonAPI)
    contentConfig.use(decoder: JSONDecoder(), for: .jsonAPI)
    services.register(contentConfig)

    // Use Leaf for rendering views
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    if let kid = Environment.get("kid"),
        let iss = Environment.get("iss"),
        let keyPath = Environment.get("keyPath") {
        try ASCApiManager.default.startService(iss: iss, kid: kid, keyPath: keyPath)
    } else {
        fatalError("kid, iss and keyPath not empty.")
    }
}
