//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import Vapor

final class Genre: Model, Content {
        static let schema = "genres"
        
        @ID
        var id: UUID?

        @Field(key: "name")
        var name: String
        
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
    init() {
        
    }
        
    
    }
