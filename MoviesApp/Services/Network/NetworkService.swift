import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchTop250Movies(completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovies(with id: String, completion: @escaping (Result<Movie, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchTop250Movies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_wzzjkk0r") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
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
                let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(response.items))
            } catch {
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchMovies(with id: String, completion: @escaping (Result<Movie, Error>) -> ()) {
        guard let url = URL(string: "https://imdb-api.com/en/API/Title/k_wzzjkk0r/\(id)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
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
                let response = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    
}
