//
//  NetworkService.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


class NetworkService: NetworkServiceProtocol {
    
    func fetchCharactersData(completion: @escaping ([Character]) -> ()) {
        let urlString = "https://the-one-api.dev/v2/character?limit=10"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer LAUsTEAZKPvH14vBQGch", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let data = try JSONDecoder().decode(CharactersResponce.self, from: data)
                    let characters = data.docs
                    completion(characters)
                } catch {
                    print(error)
                }
            }
        }.resume()
            
    }
}

