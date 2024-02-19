import Fluent
import Vapor

struct CustomerController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let customers = routes.grouped("customers")
        customers.get(use: index)
        customers.post(use: create)
        customers.group(":id") { customer in
            customer.delete(use: delete)
        }
        customers.group(":id"){ customer in
            customer.put(use: update)
        }
        
   }
                        

    // Fetch all customers
    func index(req: Request) throws -> EventLoopFuture<[Customer]> {
        return Customer.query(on: req.db).all()
    }

    // Add new customer
    func create(req: Request) throws -> EventLoopFuture<Customer> {
        let customer = try req.content.decode(Customer.self)
        return customer.save(on: req.db).map { customer }
    }

    // Fetch a customer by ID
    func get(req: Request) throws -> EventLoopFuture<Customer> {
        let recordID = req.parameters.get("id", as: UUID.self)

        return Customer.find(recordID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    // Delete a customer
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let recordID = req.parameters.get("id", as: UUID.self)
        
        return Customer.find(recordID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { customer in
                return customer.delete(on: req.db).transform(to: .noContent)
            }
    }

    // Update customer info
    func update(req: Request) throws -> EventLoopFuture<Customer> {
        let input = try req.content.decode(Customer.self)
        let recordID = req.parameters.get("id", as: UUID.self)
        
        return Customer.find(recordID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { customer in
                customer.first_name = input.first_name
                customer.last_name = input.last_name
                customer.phone_number = input.phone_number
                return customer.save(on: req.db).transform(to: customer)
            }
    }
    
}
