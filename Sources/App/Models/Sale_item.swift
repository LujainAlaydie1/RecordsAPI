
//
//  SwiftUIView.swift
//
//
//  Created by Ahlam ALshehri on 10/08/1445 AH.
//

import Fluent
import Vapor

final class Sale_item: Model, Content {
    static let schema = "Sales_items"
    
    @ID
    var id: UUID?
    
    @Parent(key: "sale_id")
    var sale : Sale

    @Parent(key: "record_id")
    var record: Record
    
    @Field(key: "quantity")
    var quantity: Int
    

  

    init() {
        
    }

    init(id: UUID? = nil, sale: Sale.IDValue, Record: Record.IDValue, quantity: Int) {
        self.id = id
        self.$sale.id = sale
        self.$record.id = Record
        self.quantity = quantity
    }
}
