//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import FluentPostgresDriver

/// Creates a database table called Records
struct CreateSalesItems: Migration {
    
    private let salesItemsTableName: String = "sales_items"
    
    /// Creates the table
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(salesItemsTableName) // table name
            .id()
            .field("sale_id", .uuid, .required, .references("sales", "id")) // referencing sales.id
            .field("record_id",.uuid, .required, .references("records", "id")) // referencing records.id
            .field("quantity", .int, .required)
            .create()
    }
    
    /// Undos the table creation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(salesItemsTableName).delete()
    }
}
