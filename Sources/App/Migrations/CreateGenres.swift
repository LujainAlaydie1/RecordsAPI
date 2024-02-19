//
//  File.swift
//
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import FluentPostgresDriver

/// Creates a database table called customer
struct CreateGenres: Migration {
    
    private let genresTableName: String = "genres"
    
    /// Creates the table
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(genresTableName) // table name
            .id()
            .field("name", .string)
            .create()
    }
    
    /// Undos the table creation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(genresTableName).delete()
    }
}
