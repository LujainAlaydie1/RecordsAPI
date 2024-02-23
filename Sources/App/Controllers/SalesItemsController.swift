//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 21/02/2024.
//

import Fluent
import Vapor

struct SaleItemController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let salesItems = routes.grouped("sales_items")
        salesItems.get(use: index)
        salesItems.post(use: create)
        salesItems.group(":id") { salesItem in
            salesItem.delete(use: delete)
            salesItem.put(use: update)
        }
        salesItems.get("bySaleID", ":sale_id", use: getBySaleID)
        salesItems.get("byRecordID", ":record_id", use: getByRecordID)


    }
    
    // Fetch all records
    func index(req: Request) throws -> EventLoopFuture<[Sale_item]> {
        return Sale_item.query(on: req.db).all()
    }
    
    // Add new record
    func create(req: Request) throws -> EventLoopFuture<Sale_item> {
        let sales_item = try req.content.decode(Sale_item.self)
        return sales_item.save(on: req.db).map { sales_item }
    }
    
    // Fetch a record by ID
    func get(req: Request) throws -> EventLoopFuture<Sale_item> {
        let saleItemID = req.parameters.get("id", as: UUID.self)
        
        return Sale_item.find(saleItemID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    
    
    // Delete a record
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let saleItemID = req.parameters.get("id", as: UUID.self)
        
        return Sale_item.find(saleItemID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { sale_item in
                return sale_item.delete(on: req.db).transform(to: .noContent)
            }
    }
    
    
    //updates
    func update(req: Request) async throws -> Sale_item{
        let newSaleItem = try req.content.decode(Sale_item.self)
        guard let SaleItemInDB =  try await Sale_item.find(newSaleItem.id, on: req.db) else{
            throw Abort(.notFound)
        }
        SaleItemInDB.sale.id = newSaleItem.sale.id
        SaleItemInDB.record.id = newSaleItem.record.id
        SaleItemInDB.quantity = newSaleItem.quantity
        try await SaleItemInDB.save(on: req.db)
        return SaleItemInDB
    }
    
    //fetch record by saleID
    func getBySaleID(req: Request) throws -> EventLoopFuture<[Sale_item]> {
            let SaleId = try req.parameters.require("sale_id", as: UUID.self)
            
            // Fetch sales associated with the customer ID
            return Sale_item.query(on: req.db)
            .filter(\.$sale.$id == SaleId)
              .all()
        }
    
    //fetch record by recordID
    func getByRecordID(req: Request) throws -> EventLoopFuture<[Sale_item]> {
            let SaleId = try req.parameters.require("record_id", as: UUID.self)
            
            // Fetch sales associated with the customer ID
            return Sale_item.query(on: req.db)
            .filter(\.$record.$id == SaleId)
                .all()
        }
    
    
    
}

