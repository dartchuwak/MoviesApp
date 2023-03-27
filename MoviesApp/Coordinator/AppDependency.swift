
import Foundation

protocol AppDependencyProtocol {
    var charactersViewModel: MoviesViewModelProtocol { get }
}

final class AppDependency {
    private let characterViewModel: MoviesViewModel
    
    init(characterViewModel: MoviesViewModel) {
        self.characterViewModel = characterViewModel
    }
    
    static func makeDefault() -> AppDependency {
        let characterViewModel = MoviesViewModel()
        return AppDependency(characterViewModel: characterViewModel)
    }
}

extension AppDependency: AppDependencyProtocol {
    
    var charactersViewModel: MoviesViewModelProtocol {
        self.characterViewModel
    }
}


