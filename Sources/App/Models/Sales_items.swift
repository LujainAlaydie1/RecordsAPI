
//
//  SwiftUIView.swift
//
//
//  Created by Ahlam ALshehri on 10/08/1445 AH.
//

import Fluent
import Vapor

final class Sales_items: Model, Content {
    static let schema = "Sales_items"
    
    @ID
    var id: UUID?
    
    @Parent(key: "sale_id")
    var Sale : Sales

    @Parent(key: "record_id")
    var Record: Record
    
    @Field(key: "quantity")
    var quantity: Int
    

  

    init() {
        
    }

    init(id: UUID? = nil, Sale: Sales, Record: Record, quantity: Int) {
        self.id = id
        self .Sale = Sale
        self.Record = Record
        self .quantity = quantity
    }
}
