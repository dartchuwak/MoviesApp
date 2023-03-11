//
//  ListModuleViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol CharacterViewModelProtocol: AnyObject {
    var characters: [Character] { get set }
    var reload: (() -> ())? { get set }
    var quotes: [Quote] { get }
    func numberOfItemsInSection() -> Int
    func viewModelForSelectedItem() -> DetailsViewModelProtocol?
    func selectRow(indexPath: IndexPath)
    func makeChars()
}


final class CharacterViewModel: CharacterViewModelProtocol {
    
    private var selectedIndexPath: IndexPath?
    private var isLoading = false
    var quotes: [Quote] = []
    var characters: [Character] = []
    var reload: (() -> ())?
    
    
    func numberOfItemsInSection() -> Int {
        return characters.count
    }
    
    func makeChars() {
        let names = names.sorted(by: <)
        for i in names {
            characters.append(Character(id: i.key, name: i.value))
        }
    }
    
    func viewModelForSelectedItem() -> DetailsViewModelProtocol? {
        guard let indexPath = selectedIndexPath else { return nil}
        return DetailsViewModel(characterData: characters[indexPath.item], networkService: NetworkService())
    }
    
    func selectRow(indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}
