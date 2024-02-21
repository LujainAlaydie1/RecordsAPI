
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

    @Field(key: "date_time")
    var date_time: String
    
    @Parent(key: "customer_id")
    var customer_id: Customer
    
    @Field(key: "discount_applied")
    var discount_applied: Double
    
  

    init() {
        
    }

    init(id: UUID? = nil, name: String, date_time: String,customer_id: Customer.IDValue, discount_applied: String) {
        self.id = id
        self.name = name
        self .date_time = date_time
        self.$customer_id.id = customer_id
        self.discount_applied = 0.0
    }
}
