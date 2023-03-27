//
//  Quotes.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 06.03.2023.
//

import Foundation


struct Quote: Decodable {
    let _id: String?
    let dialog: String?
    let movie:String
    let character:String?
    let id:String?
}


struct QuotesResponce: Decodable {
    let docs: [Quote]
    let total: Int?
    let limit: Int?
    let offset: Int?
    let page: Int?
    let pages: Int?
}
