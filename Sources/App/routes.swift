import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    try router.register(collection: AppController())
    try router.register(collection: UserController())
    try router.register(collection: BundleIDController())
    try router.register(collection: DeviceController())
}
