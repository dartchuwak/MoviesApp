//
//  ConChar.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 07.03.2023.
//

import Foundation


struct Movie: Decodable {
    let id: String
    let title: String
    let image: String
}

struct Poster: Decodable {
    let url: String
    let previewUrl: String
}

struct Trailer: Decodable {
    
}
struct MoviesResponse: Decodable {
    let items: [Movie]
}




