import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchMovies() async -> Result<[Movie], NetworkError>
    func fetchMovieDetails(with id: String) async -> Result<Movie, NetworkError>
    func searchMovies(with text: String) async -> Result<[Movie], NetworkError>
    //Use witout API
//    func loadLocalMovies(completion: @escaping (Result<[Movie], Error>) -> ())
//    func loadLocalMoviesDetails(completion: @escaping (Result<Movie, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMovies() async -> Result<[Movie], NetworkError> {
        guard var url = URLComponents(string: "https://api.kinopoisk.dev/v1/movie") else { return .failure(.invalidURL) }
        url.queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "backdrop.previewUrl", value: "!null")
        ]
        guard let url = url.url else { return  .failure((.invalidURL))}
        var request = URLRequest(url: url)
        request.addValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return .success(result.docs)
        } catch {
            return .failure(.emptyResponse)
        }
    }
    
    
    func fetchMovieDetails(with id: String) async -> Result<Movie, NetworkError> {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/movie/\(id)") else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url)
        request.addValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(Movie.self, from: data)
            return .success(result)
        } catch {
            return .failure(.emptyResponse)
        }
    }
    
    func searchMovies(with text: String) async -> Result<[Movie], NetworkError> {
        
        guard var url = URLComponents(string: "https://api.kinopoisk.dev/v1/movie") else { return .failure(.invalidURL) }
        url.queryItems = [
            URLQueryItem(name: "name", value: text),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "backdrop.url", value: "!null"),
        ]
        guard let url = url.url else { return .failure(.invalidURL)}
        var request = URLRequest(url: url)
        request.addValue("TMSVW3E-05TMGH9-MMW9SWN-20GAGBY", forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return .success(result.docs)
        } catch {
            return .failure(.emptyResponse)
        }
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
