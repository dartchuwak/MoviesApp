//
//  ConChar.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 07.03.2023.
//

import Foundation


struct Movie: Decodable {
    let id: Int
    let name: String?
    let enName: String?
    let alternativeName: String?
    let poster: Poster
    let backdrop: Backdrop?
    let rating: Rating
    let year: Int
    let countries: [Countries]
    let genres: [Genres]
    let shortDescription: String
    let description: String
    let videos : Video?
}

struct Poster: Decodable {
    let url: String
    let previewUrl: String
}

struct Backdrop: Decodable {
    let url: String
    let previewUrl: String
}

struct Rating : Decodable {
    let kp: Float
}
struct Genres: Decodable {
    let name: String
}

struct Countries: Decodable {
    let name: String
}

struct Video: Decodable {
    
    let trailers: [Trailer]?
    let teasers: [Teaser]?
}

struct Trailer: Decodable {
    let url: String
    let name: String
    let site: String
}

struct Teaser: Decodable {
    
}

struct MoviesResponse: Decodable {
    let docs: [Movie]
}




