import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovieDetails(with id: String, completion: @escaping (Result<Movie, Error>) -> ())
    func searchMovies(with text: String, completion: @escaping (Result<[Movie], Error>) -> ())
    //Use witout API
//    func loadLocalMovies(completion: @escaping (Result<[Movie], Error>) -> ())
//    func loadLocalMoviesDetails(completion: @escaping (Result<Movie, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        guard var url = URLComponents(string: "https://api.kinopoisk.dev/v1/movie") else { return }
        url.queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "backdrop.previewUrl", value: "!null"),
        ]
        guard let url = url.url else { return }
        var request = URLRequest(url: url)
        request.addValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        
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
                completion(.success(response.docs))
            } catch {
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchMovieDetails(with id: String, completion: @escaping (Result<Movie, Error>) -> ()) {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/movie/\(id)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        
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
    
    func searchMovies(with text: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        
        guard var url = URLComponents(string: "https://api.kinopoisk.dev/v1/movie") else { return }
        url.queryItems = [
            URLQueryItem(name: "name", value: text),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "backdrop.url", value: "!null"),
        ]
        guard let url = url.url else { return }
        var request = URLRequest(url: url)
        request.addValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        print(request)
        
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
                completion(.success(response.docs))
            } catch {
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    //Use witout API
    
//    func loadLocalMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
//        
//        guard let path = Bundle.main.url(forResource: "Movies", withExtension: "json") else { return }
//        guard let jsonData = try? Data(contentsOf: path) else { return }
//        let decoder = JSONDecoder()
//        do {
//            let response = try decoder.decode(MoviesResponse.self, from: jsonData)
//            completion(.success(response.docs))
//        } catch {
//            completion(.failure(error))
//            print("Error: \(error)")
//        }
//    }
//    
//    func loadLocalMoviesDetails(completion: @escaping (Result<Movie, Error>) -> ()) {
//        
//        guard let path = Bundle.main.url(forResource: "movieDetails", withExtension: "json") else { return }
//        guard let jsonData = try? Data(contentsOf: path) else { return }
//        let decoder = JSONDecoder()
//        do {
//            let response = try decoder.decode(Movie.self, from: jsonData)
//            completion(.success(response))
//        } catch {
//            completion(.failure(error))
//            print("Error: \(error)")
//      }
//  }
}
