import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchCharacterQuotes(for characterId: String, completion: @escaping (Result<[Quote]?, Error>) -> ())
    func fetchCharacterDetails(for characterId: String, completion: @escaping (Result<[CharacterDetails]?, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCharacterQuotes(for characterId: String, completion: @escaping (Result<[Quote]?, Error>) -> ()) {
        guard let url = URL(string: "https://the-one-api.dev/v2/character/\(characterId)/quote") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer LAUsTEAZKPvH14vBQGch", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(QuotesResponce.self, from: data)
                completion(.success(response.docs ))
            } catch {
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchCharacterDetails(for characterId: String, completion: @escaping (Result<[CharacterDetails]?, Error>) -> ()) {
        guard let url = URL(string: "https://the-one-api.dev/v2/character/\(characterId)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer LAUsTEAZKPvH14vBQGch", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CharacterDetailsResponce.self, from: data)
                completion(.success(response.docs))
            } catch {
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}
