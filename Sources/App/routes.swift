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
    
    // Group routes for records
    let recordController = RecordsController()

       /// Group routes for records
    app.group("records") { records in
        
        // Fetch records by genre
        records.get("bygenre") { req -> EventLoopFuture<[Record]> in
            return try recordController.getByGenre(req: req)
        }
        
        // Fetch a record by its name
        records.get("byname") { req -> EventLoopFuture<Record> in
            return try recordController.getByname(req: req)
        }
    }
    
    
    
}
