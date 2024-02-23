//
//  File.swift
//  
//
//  Created by Lujain Alaydie on 19/02/2024.
//

import Fluent
import Vapor

struct RecordsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let records = routes.grouped("records")
        records.get(use: index)
        records.post(use: create)
        records.group(":id") { record in
            record.delete(use: delete)
        }
        records.group(":id"){ record in
            record.put(use: update)
        }
        records.get("byName", ":name", use: getByname)
        records.get("byGenre", ":genre", use: getByGenre) 


   }

    // Fetch all records
    func index(req: Request) throws -> EventLoopFuture<[Record]> {
        return Record.query(on: req.db).all()
    }

    // Add new record
    func create(req: Request) throws -> EventLoopFuture<Record> {
        let record = try req.content.decode(Record.self)
        return record.save(on: req.db).map { record }
    }

    // Fetch a record by ID
    func get(req: Request) throws -> EventLoopFuture<Record> {
        let recordID = req.parameters.get("id", as: UUID.self)

        return Record.find(recordID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    

    // Delete a record
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let recordID = req.parameters.get("id", as: UUID.self)
        
        return Record.find(recordID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { record in
                return record.delete(on: req.db).transform(to: .noContent)
            }
    }
  
    // Update record info
    func update(req: Request) throws -> EventLoopFuture<Record> {
        let input = try req.content.decode(Record.self)
        let recordID = req.parameters.get("id", as: UUID.self)
        
        return Record.find(recordID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { record in
                record.name = input.name
                record.artist_name = input.artist_name
                record.price = input.price
                record.quantity = input.quantity
                record.genre = input.genre
                return record.save(on: req.db).transform(to: record)
            }
    }
    
    // Handler to get a genre by its name
        func getByname(req: Request) throws -> EventLoopFuture<Record> {
            guard let name = req.parameters.get("name", as: String.self) else {
                throw Abort(.badRequest)
            }
            
            return Record.query(on: req.db)
                .filter(\.$name == name)
                .first()
                .unwrap(or: Abort(.notFound))
        }
    
    
    func getByGenre(req: Request) throws -> EventLoopFuture<[Record]> {
        guard let genreID = req.parameters.get("genre", as: UUID.self) else {
            throw Abort(.badRequest)
        }

        // Query the database to find records with the specified genre ID
        return Record.query(on: req.db)
            .filter(\.$genre.$id == genreID)
            .all()
    }

    
    
    

    
}
