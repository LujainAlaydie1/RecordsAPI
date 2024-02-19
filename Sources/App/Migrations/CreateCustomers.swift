//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 18/02/2024.
//

import Fluent
import FluentPostgresDriver

/// Creates a database table called customer
struct CreateCustomer: Migration {
    
    private let customersTableName: String = "customers"
    
    /// Creates the table
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(customersTableName) // table name
            .id()
            .field("first_name", .string)
            .field("last_name", .string)
            .field("phone_number", .string)

            .create()
    }
    
    /// Undos the table creation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(customersTableName).delete()
    }
}
