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

 func convertToKFormat(number: Int) -> String {
    let num = Double(number)
    let sign = ((num < 0) ? "-" : "" )
    let absNum = fabs(num)
    if absNum < 1000.0 {
        return "\(sign)\(Int(absNum))"
    }
    let exp = Int(log10(absNum) / 3.0 ) // power of 1000
    let units = ["K", "M", "B", "T", "P", "E"]
    let roundedNum = round(10 * absNum / pow(1000.0, Double(exp))) / 10
    return "\(sign)\(Int(roundedNum * 10) / 10)\(units[exp-1])"
}



