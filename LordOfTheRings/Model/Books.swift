//
//  Books.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation

struct Book: Decodable {
    let _id: String
    let name: String
}

struct Responce: Decodable {
    let docs: [Book]
    let total: Int
    let limit: Int
    let offset: Int
    let page: Int
    let pages: Int
}

