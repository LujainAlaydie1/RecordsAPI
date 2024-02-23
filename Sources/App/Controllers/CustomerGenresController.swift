//
//  File.swift
//
//
//  Created by JAY on 21/02/2024.
//

import Fluent
import Vapor

struct CustomerGenreController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let customers_genre = routes.grouped("customers_genres")
        customers_genre.get(use: index)
        customers_genre.post(use: create)
        customers_genre.delete(":id", use: delete)
        customers_genre.group(":id"){ customers_genre in
            customers_genre.put(use: update)
        }
        customers_genre.get("byCustomer", ":customer_id", use: getByCustomerID)
        customers_genre.get("byGenre", ":genres_id", use: getByGenresID)

        
    }


    // Fetch all customer-genre
    func index(req: Request) throws -> EventLoopFuture<[Customer_Genre]> {
        return Customer_Genre.query(on: req.db).all()
    }

    // Add new customer-genre
    func create(req: Request) throws -> EventLoopFuture<Customer_Genre> {
        let customers_genre = try req.content.decode(Customer_Genre.self)
        return customers_genre.save(on: req.db).map { customers_genre }
    }

    // Fetch a customer-genre by ID
    func get(req: Request) throws -> EventLoopFuture<Customer_Genre> {
        let customers_genreID = req.parameters.get("id", as: UUID.self)

        return Customer_Genre.find(customers_genreID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let recordID = req.parameters.get("id", as: UUID.self)
    
        return Customer_Genre.find(recordID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { record in
                return record.delete(on: req.db).transform(to: .noContent)
            }
    }
    

    // Update customer-genre info
    func update(req: Request) throws -> EventLoopFuture<Customer_Genre> {
        let input = try req.content.decode(Customer_Genre.self)
        let customers_genreID = req.parameters.get("id", as: UUID.self)
        
        return Customer_Genre.find(customers_genreID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { Customer_Genre in
             
                return Customer_Genre.save(on: req.db).transform(to: Customer_Genre)
            }
    }
    
    //get by customer ID
    func getByCustomerID(req: Request) throws -> EventLoopFuture<[Customer_Genre]> {
            let customerId = try req.parameters.require("customer_id", as: UUID.self)
            
            // Fetch sales associated with the customer ID
            return Customer_Genre.query(on: req.db)
                .filter(\.$customer_id.$id == customerId)
                .all()
        }
    //get by customer ID
    func getByGenresID(req: Request) throws -> EventLoopFuture<[Customer_Genre]> {
            let genresID = try req.parameters.require("genres_id", as: UUID.self)
            
            // Fetch sales associated with the customer ID
            return Customer_Genre.query(on: req.db)
                .filter(\.$genres_id.$id == genresID)
                .all()
        }
    
    
}
