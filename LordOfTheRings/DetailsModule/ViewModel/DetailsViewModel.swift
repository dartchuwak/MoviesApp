//
//  DetailsViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol DetailsViewModelProtocol: AnyObject {
    
    var characterName: String { get }
}



class DetailsViewModel: DetailsViewModelProtocol {
    
    
    var characterName: String {
        return String(describing: "\(character.name!)")
    }
    
    
   private var character: Character
    
    init (character: Character) {
        self.character = character
    }
}

