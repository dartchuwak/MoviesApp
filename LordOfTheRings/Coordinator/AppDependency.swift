
import Foundation

protocol AppDependencyProtocol {
    var charactersViewModel: CharacterViewModelProtocol { get }
}

final class AppDependency {
    private let characterViewModel: CharacterViewModel
    
    init(characterViewModel: CharacterViewModel) {
        self.characterViewModel = characterViewModel
    }
    
    static func makeDefault() -> AppDependency {
        let characterViewModel = CharacterViewModel()
        return AppDependency(characterViewModel: characterViewModel)
    }
}

extension AppDependency: AppDependencyProtocol {
    
    var charactersViewModel: CharacterViewModelProtocol {
        self.characterViewModel
    }
}


