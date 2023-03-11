//
//  DetailsViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol DetailsViewModelProtocol: AnyObject {
    //var characterData: Character? { get set }
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
        let movies = [
            MoviesEnum.bookOne.rawValue: "The Fellowship of The Ring",
            MoviesEnum.bookTwo.rawValue: "The Two Towers",
            MoviesEnum.bookThree.rawValue: "The Return of The King"
        ]
        return movies[quote.movie] ?? "Sorry, no data"
    }
    
    init (characterData: Character, networkService: NetworkServiceProtocol) {
        self.characterData = characterData
        self.networkService = networkService
    }
    
    func fetchData()  {
        guard !isLoading else { return }
        isLoading = true
        guard let character = characterData else { return }
        dispatchGroup.enter()
        networkService.fetchCharacterQuotes(for: character.id , completion: { [weak self] result in
                guard let self = self  else { return }
                self.dispatchGroup.leave()
                switch result {
                case .success(let quotes):
                    self.quote = quotes?.randomElement()
                case .failure(let error):
                    print (error)
                }
            })
        
        dispatchGroup.enter()
        networkService.fetchCharacterDetails( for: character.id) { [weak self] result in
            guard let self = self  else { return }
            self.dispatchGroup.leave()
                switch result {
                case .success(let character):
                    guard let character = character else { return }
                    if character.isEmpty { return }
                    self.characterDetails = character.first
                    if let details = self.characterDetails {
                        self.characterBirthDeath = "\(details.birth) - \(details.death)"
                    }
                case .failure(let error):
                    print (error)
                }
            }
        
        dispatchGroup.notify(queue: .main) {
            self.reload?()
        }
        
    }
}

