import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: CustomerController())
    try app.register(collection: RecordsController())
    try app.register(collection: SaleController())
    try app.register(collection: SaleItemController())
    try app.register(collection: GenreController())
    try app.register(collection: CustomerGenreController())
    

}
