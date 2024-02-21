//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import FluentPostgresDriver

/// Creates a database table called customer
struct CreateCustomersGenres: Migration {
    
    private let customersGenresTableName: String = "customers_genres"
    
    /// Creates the table
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(customersGenresTableName) // table name
            .id()
            .field("customer_id",  .uuid, .required, .references("customers", "id")) // referencing customers.id
            .field("genres_id",  .uuid, .required, .references("genres", "id")) // referencing customers.id


            .create()
    }
    
    /// Undos the table creation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(customersGenresTableName).delete()
    }
}
