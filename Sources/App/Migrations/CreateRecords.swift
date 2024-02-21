//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import FluentPostgresDriver

/// Creates a database table called Records
struct CreateRecords: Migration {
    
    private let recordsTableName: String = "records"
    
    /// Creates the table
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(recordsTableName) // table name
            .id()
            .field("name", .string, .required)
            .field("artist_name", .string)
            .field("price", .double, .required)
            .field("quantity", .int, .required)
            .field("genre_id", .uuid, .references("genres", "id")) // referencing genres.id
            .create()
    }
    
    /// Undos the table creation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(recordsTableName).delete()
    }
}
