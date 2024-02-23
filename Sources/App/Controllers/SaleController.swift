//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 21/02/2024.
//

import Fluent
import Vapor

struct SaleController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let sales = routes.grouped("sales")
        sales.get(use: index)
        sales.post(use: create)
        sales.group(":id") { record in
            record.delete(use: delete)
            record.put(use: update)
        }        
        sales.get("byCustomer", ":customer_id", use: getByCustomerID)

    }
    
    // Fetch all records
    func index(req: Request) throws -> EventLoopFuture<[Sale]> {
        return Sale.query(on: req.db).all()
    }
    
    // Add new record
    func create(req: Request) throws -> EventLoopFuture<Sale> {
        let sale = try req.content.decode(Sale.self)
        return sale.save(on: req.db).map { sale }
    }
    
    // Fetch a record by ID
    func get(req: Request) throws -> EventLoopFuture<Sale> {
        let saleID = req.parameters.get("id", as: UUID.self)
        
        return Sale.find(saleID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    
    
    // Delete a record
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let saleID = req.parameters.get("id", as: UUID.self)
        
        return Sale.find(saleID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { sale in
                return sale.delete(on: req.db).transform(to: .noContent)
            }
    }
    
    
    // Update record info
    func update(req: Request) throws -> EventLoopFuture<Sale> {
        let input = try req.content.decode(Sale.self)
        let saleID = req.parameters.get("id", as: UUID.self)
        
        return Sale.find(saleID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { sale in
                sale.name = input.name
                sale.customer_id = input.customer_id
                sale.discount_applied = input.discount_applied
                return sale.save(on: req.db).transform(to: sale)
            }
    }
    
    //get by customer ID
    func getByCustomerID(req: Request) throws -> EventLoopFuture<[Sale]> {
        guard let customerId = req.parameters.get("customer_id", as: UUID.self)else{
            throw Abort(.badRequest)

        }

            // Fetch sales associated with the customer ID
            return Sale.query(on: req.db)
            .filter(\.$customer_id.$id == customerId)
                .all()
        }
    
    
       }

