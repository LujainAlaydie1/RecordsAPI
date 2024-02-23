
//
//  Sales.swift
//  RecordsAPI
//
//  Created by Ahlam ALshehri on 10/08/1445 AH.
//

import Fluent
import Vapor

final class Sale: Model, Content {
    static let schema = "sales"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name : String
    
    @Parent(key: "customer_id")
    var customer_id: Customer
    
    @Field(key: "discount_applied")
    var discount_applied: Double
    
  

    init() {
        
    }

    init(id: UUID? = nil, name: String, customer_id: Customer.IDValue, discount_applied: Double) {
        self.id = id
        self.name = name
        self.$customer_id.id = customer_id
        self.discount_applied = 0.0
    }
}
