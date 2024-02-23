import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.postgres (configuration: SQLPostgresConfiguration(hostname: "localhost",
                                                               username: "postgres", password: "",
                                                               database: "my_records",
                                                               tls: .prefer(try .init(configuration:.clientDefault)))), as: .psql)
                      

    //CREATE ALL TABLES
    app.migrations.add(CreateCustomer())
    app.migrations.add(CreateGenres())
    app.migrations.add(CreateSales())
    app.migrations.add(CreateRecords())
    app.migrations.add(CreateSalesItems())
    app.migrations.add(CreateCustomersGenres())
    try await app.autoMigrate()
//    try await app.autoRevert()
    // register routes
    try routes(app)
}
