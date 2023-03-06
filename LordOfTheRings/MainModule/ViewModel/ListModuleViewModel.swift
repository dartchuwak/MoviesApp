//
//  ListModuleViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol ListModuleViewModelProtocol: AnyObject {
    func numberOfItemsInSection() -> Int
  //  func cellViewModel(indexPath: IndexPath) -> ListModuleCollectionViewCellViewModelProtocol?
    func fetchData(completion: @escaping() -> ())
    var characters: [Character] { get }
    func viewModelForSelectedItem() -> DetailsViewModelProtocol?
    func selectRow( indexPath: IndexPath)
   // var appCoordinator: CoordinatorProtocol? { get set }
}


class ListModuleViewModel: ListModuleViewModelProtocol {
    
    weak var appCoordinator: Coordinator?
    
    private var selectedIndexPath: IndexPath?
    var networkManager: NetworkServiceProtocol! = NetworkService() // Нужно DI
    var characters: [Character] = []
    

    func numberOfItemsInSection() -> Int {
        return characters.count
    }
    
    func fetchData(completion: @escaping() -> ()) {
        networkManager.fetchCharactersData(completion: { [weak self]  characters  in
            guard let self = self else { return }
            self.characters = characters
            completion()
        })
    }
    
//    func goToDetails(){
//        appCoordinator!.gotoListPage()
//       }
    
//    func cellViewModel(indexPath: IndexPath) -> ListModuleCollectionViewCellViewModelProtocol? {
//        //code
//    }
    
    func viewModelForSelectedItem() -> DetailsViewModelProtocol? {
        return DetailsViewModel(character: characters[selectedIndexPath!.item])
    }
    
    func selectRow(indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
