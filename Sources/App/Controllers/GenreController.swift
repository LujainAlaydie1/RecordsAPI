//
//  File.swift
//
//
//  Created by JAY on 21/02/2024.
//

import Foundation
import Vapor
import Fluent


struct GenreController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let genre = routes.grouped("genres")
        genre.get(use: index)
        genre.post(use: create)
        genre.group(":id") { genre in
            genre.delete(use: delete)
        }
        genre.group(":id"){ genre in
            genre.put(use: update)
        }
        genre.get("byName", ":name", use: getByname) // Route to get a genre by name

    }
    
    
    // Fetch all Genres
    func index(req: Request) throws -> EventLoopFuture<[Genre]> {
        return Genre.query(on: req.db).all()
    }
    
    // Add new Genre
    func create(req: Request) throws -> EventLoopFuture<Genre> {
        let genre = try req.content.decode(Genre.self)
        return genre.save(on: req.db).map { genre }
    }
    
    // Fetch a Genre by ID
    func get(req: Request) throws -> EventLoopFuture<Genre> {
        let genreID = req.parameters.get("id", as: UUID.self)
        
        return Genre.find(genreID, on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // Delete a Genre
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let genreID = req.parameters.get("id", as: UUID.self)
        
        return Genre.find(genreID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { genre in
                return genre.delete(on: req.db).transform(to: .noContent)
            }
    }
    
    // Update Genre info
    func update(req: Request) throws -> EventLoopFuture<Genre> {
        let input = try req.content.decode(Genre.self)
        let genreID = req.parameters.get("id", as: UUID.self)
        
        return Genre.find(genreID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { genre in
                
                genre.name = input.name
                return genre.save(on: req.db).transform(to: genre)
            }
    }
    
    
    // Handler to get a genre by its name
        func getByname(req: Request) throws -> EventLoopFuture<Genre> {
            guard let name = req.parameters.get("name", as: String.self) else {
                throw Abort(.badRequest)
            }
            
            return Genre.query(on: req.db)
                .filter(\.$name == name)
                .first()
                .unwrap(or: Abort(.notFound))
        }
    
}
