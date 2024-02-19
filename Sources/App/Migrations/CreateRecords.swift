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
    
    private let recordsTabelName: String = "records"
    
    /// Creates the table
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(recordsTabelName) // table name
            .id()
            .field("name", .string)
            .field("artist_name", .string)
            .field("price", .double)
            .field("quantity", .int)
            .field("genre_id", .uuid, .references("genres", "id")) // referencing genres.id
            .create()
    }
    
    /// Undos the table creation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(recordsTabelName).delete()
    }
}
