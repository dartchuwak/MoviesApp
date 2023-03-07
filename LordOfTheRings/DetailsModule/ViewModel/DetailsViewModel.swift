//
//  DetailsViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol DetailsViewModelProtocol: AnyObject {
    var characterData: Character? { get set }
    var quote: Quote? { get }
    var movie: String { get }
    var reload: (() -> ())? { get set }
    var networkService: NetworkServiceProtocol { get set }
    func fetchData()
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    var quote: Quote?
    var characterData: Character?
    private var quotes: [Quote] = []
    var reload: (() -> ())?
    var isLoading: Bool = false
    var networkService: NetworkServiceProtocol
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
        guard !isLoading else { return}
        isLoading = true
        networkService.fetchCharacterQuotes(characterId: characterData!.id , completion: { [self] result in
            switch result {
            case .success(let quotes):
                guard let quotes = quotes else { return }
                if quotes.isEmpty {
                    return
                }
                self.quotes = quotes
                self.quote = self.quotes.randomElement()!
                self.reload?()
            case .failure(let error):
                print (error)
            }
        })
        
    }
}

