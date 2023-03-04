//
//  Character.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation

struct Character: Decodable {
    let _id: String?
    let race: String?
    let gender: String?
    let birth: String?
    let spouse: String?
    let death: String?
    let realm: String?
    let hair: String?
    let name: String?
    let wikiUrl: String?
}

struct CharactersResponce: Decodable {
    let docs: [Character]
    let total: Int
    let limit: Int
    let offset: Int
    let page: Int
    let pages: Int
}



