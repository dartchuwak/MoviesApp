
import Foundation

protocol AppDependencyProtocol {
    var moviesViewModel: MoviesViewModelProtocol { get }
}

final class AppDependency {
    private let movieViewModel: MoviesViewModel
    
    init(movieViewModel: MoviesViewModel) {
        self.movieViewModel = movieViewModel
    }
    
    static func configure() -> AppDependency {
        let movieViewModel = MoviesViewModel()
        return AppDependency(movieViewModel: movieViewModel)
    }
}

extension AppDependency: AppDependencyProtocol {
    
    var moviesViewModel: MoviesViewModelProtocol {
        self.movieViewModel
    }
}


