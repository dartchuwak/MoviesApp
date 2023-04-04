import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchMovies() async -> Result<MoviesResponse, NetworkError>
    func fetchMovieDetails(with id: String) async -> Result<Movie, NetworkError>
    func searchMovies(with text: String) async -> Result<MoviesResponse, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    let apiKey = "TMSVW3E-05TMGH9-MMW9SWN-20GAGBY"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
    
    private func fetchData<T: Decodable>(request: URLRequest) async -> Result<T, NetworkError> {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(.emptyResponse)
        }
    }
    
    func fetchMovies() async -> Result<MoviesResponse, NetworkError> {
        guard var url = URLComponents(string: "https://api.kinopoisk.dev/v1/movie") else { return .failure(.invalidURL) }
        url.queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "backdrop.previewUrl", value: "!null")
        ]
        guard let url = url.url else { return  .failure((.invalidURL))}
        let request = createRequest(url: url)
        return await fetchData(request: request)
    }
    
    func fetchMovieDetails(with id: String) async -> Result<Movie, NetworkError> {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/movie/\(id)") else { return .failure(.invalidURL)}
        let request = createRequest(url: url)
        return await fetchData(request: request)
    }
    
    func searchMovies(with text: String) async -> Result<MoviesResponse, NetworkError> {
        guard var url = URLComponents(string: "https://api.kinopoisk.dev/v1/movie") else { return .failure(.invalidURL) }
        url.queryItems = [
            URLQueryItem(name: "name", value: text),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "backdrop.url", value: "!null"),
        ]
        guard let url = url.url else { return .failure(.invalidURL)}
        let request = createRequest(url: url)
        return await fetchData(request: request)
    }
}
