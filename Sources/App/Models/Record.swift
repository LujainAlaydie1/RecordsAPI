//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import Vapor


final class Record: Model, Content {
    static let schema = "records"
    
    @ID
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "artist_name")
    var artist_name: String
    
    @Field(key: "price")
    var price: Double
    
    @Field(key: "quantity")
    var quantity: Int
    
    @Parent(key: "genre_id")
    var genre: Genre
    
    
    init(id: UUID? = nil, name: String, artist_name: String, price: Double, quantity: Int, genre_id: Genre.IDValue) {
        self.id = id
        self.name = name
        self.artist_name = artist_name
        self.price = price
        self.quantity = quantity
        self.$genre.id = genre_id
    }
    
    init() {
        
    }
}
