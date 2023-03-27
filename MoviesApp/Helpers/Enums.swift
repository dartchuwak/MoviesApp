//
//  Enums.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 06.03.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case emptyResponse
}

enum MoviesEnum: String {
    case bookOne = "5cd95395de30eff6ebccde5c"
    case bookTwo = "5cd95395de30eff6ebccde5b"
    case bookThree = "5cd95395de30eff6ebccde5d"
}



