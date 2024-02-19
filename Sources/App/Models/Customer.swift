import Fluent
import Vapor

final class Customer: Model, Content {
    static let schema = "customers"
    
    @ID
    var id: UUID?

    @Field(key: "first_name")
    var first_name: String
    
    @Field(key: "last_name")
    var last_name: String
    
    @Field(key: "phone_number")
    var phone_number: String
    
    

    init() { 
        
    }

    init(id: UUID? = nil, first_name: String, last_name: String, phone_number: String) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.phone_number = phone_number
    }
}
