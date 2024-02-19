//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import FluentPostgresDriver

/// Creates a database table called Records
struct CreateSales: Migration {
    
    private let salesTabelName: String = "sales"
    
    /// Creates the table
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(salesTabelName) // table name
            .id()
            .field("name", .string)
            .field("date_time", .datetime)
            .field("customer_id",  .uuid, .references("customers", "id")) // referencing customers.id
            .field("discount_applied", .double)
            .create()
    }
    
    /// Undos the table creation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(salesTabelName).delete()
    }
}
