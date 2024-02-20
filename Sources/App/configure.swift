import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
<<<<<<< Updated upstream

=======
    app.databases.use(.postgres (configuration: SQLPostgresConfiguration(hostname: "localhost",
                                                               username: "postgres", password: "",
                                                               database: "my_records",
                                                               tls: .prefer(try .init(configuration:.clientDefault)))), as: .psql)
                      
>>>>>>> Stashed changes
//    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
//        tls: .prefer(try .init(configuration: .clientDefault)))
//    ), as: .psql)
<<<<<<< Updated upstream
    app.databases.use(.postgres (configuration: SQLPostgresConfiguration(hostname: "localhost",
                                                               username: "postgres", password: "",
                                                               database: "my_records",
                                                               tls: .prefer(try .init(configuration:.clientDefault)))), as: .psql)

    //CREATE ALL TABLES
    app.migrations.add(CreateCustomer())
    app.migrations.add(CreateGenres())
    app.migrations.add(CreateRecords())
    app.migrations.add(CreateSales())
    app.migrations.add(CreateSalesItems())
    app.migrations.add(CreateCustomersGenres())
    try await app.autoMigrate()
    
=======
>>>>>>> Stashed changes


    // register routes
    try routes(app)
}