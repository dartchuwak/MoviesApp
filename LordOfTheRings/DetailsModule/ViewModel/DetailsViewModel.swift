//
//  DetailsViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol DetailsViewModelProtocol: AnyObject {
    var characterData: Character? { get set }
    var characterDetails: CharacterDetails? { get }
    var quote: Quote? { get }
    var movie: String { get }
    var reload: (() -> ())? { get set }
    var networkService: NetworkServiceProtocol { get }
    var characterBirthDeath: String? { get set }
    func fetchData()
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    var quote: Quote?
    var characterBirthDeath: String?
    var characterData: Character?
    var characterDetails: CharacterDetails?
    var reload: (() -> ())?
    var isLoading: Bool = false
    var networkService: NetworkServiceProtocol
    let dispatchGroup = DispatchGroup()
    var movie: String {
        
        guard let quote = quote else { return "Sorry, no data"}
        if quote.movie == MoviesEnum.bookOne.rawValue {
            return "The Fellowship of The Ring"
        }
        if quote.movie == MoviesEnum.bookTwo.rawValue {
            return "The Two Towers"
        }
        if quote.movie == MoviesEnum.bookThree.rawValue {
            return "The Return of The King"
        }
        return "Sorry, no data"
    }
    
    init (characterData: Character, networkService: NetworkServiceProtocol) {
        self.characterData = characterData
        self.networkService = networkService
    }
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        dispatchGroup.enter()
            networkService.fetchCharacterQuotes(characterId: characterData!.id , completion: { [self] result in
                dispatchGroup.leave()
                switch result {
                case .success(let quotes):
                    self.quote = quotes?.randomElement()
                case .failure(let error):
                    print (error)
                }
            })
        dispatchGroup.enter()
            networkService.fetchCharacterDetails(characterId: characterData!.id) { [self] result in
                dispatchGroup.leave()
                switch result {
                case .success(let character):
                    guard let character = character else { return }
                    if character.isEmpty { return }
                    self.characterDetails = character.first
                    self.characterBirthDeath = "\(characterDetails!.birth) - \(characterDetails!.death)"
                case .failure(let error):
                    print (error)
                }
            }
        
        dispatchGroup.notify(queue: .main) {
            self.reload?()
            
        }
        
    }
}

