//
//  NetworkService.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchCharacterQuotes(characterId: String, completion: @escaping (Result<[Quote]?, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func fetchCharacterQuotes(characterId: String, completion: @escaping (Result<[Quote]?, Error>) -> ()) {
        let urlString = "https://the-one-api.dev/v2/character/\(characterId)/quote"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer LAUsTEAZKPvH14vBQGch", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let data = try JSONDecoder().decode(QuotesResponce.self, from: data)
                    let quotes  = data.docs
                    completion(.success(quotes))
                } catch {
                    completion(.failure(error))
                    print("Ошибка: \(error)")
                }
            }
        }.resume()
    }
}


