//
//  ConChar.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 07.03.2023.
//

import Foundation


struct Movie: Decodable {
    let id: Int
    let name: String
    let poster : Poster
}

struct Poster: Decodable {
    let url: String
    let previewUrl: String
}
struct MoviesResponse: Decodable {
    let docs: [Movie]
}




