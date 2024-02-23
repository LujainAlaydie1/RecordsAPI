//
//  File.swift
//
//
//  Created by JAY on 21/02/2024.
//

import Vapor
import Fluent

final class Customer_Genre: Model, Content {
    static let schema = "customers_genres"
    
    @ID
    var id: UUID?
    
    @Parent(key:"customer_id")
    var customer_id : Customer

    @Parent(key:"genres_id")
    var genres_id : Genre
    
    init(id: UUID? = nil, customer_id: Customer.IDValue, genres_id: Genre.IDValue) {
        self.id = id
        self.$customer_id.id = customer_id
        self.$genres_id.id = genres_id
    }
    
    init() {
        
    }
    
}
