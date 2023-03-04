//
//  NetworkServiceProtocol.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol NetworkServiceProtocol: AnyObject {
    
    func fetchCharactersData(completion: @escaping ([Character]) -> ())
}
