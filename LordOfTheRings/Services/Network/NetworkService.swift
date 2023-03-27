import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovies(with id: String, completion: @escaping (Result<Movie, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/movie") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        
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
                completion(.success(response.docs ))
            } catch {
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchMovies(with id: String, completion: @escaping (Result<Movie, Error>) -> ()) {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/movie/\(id)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        
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
