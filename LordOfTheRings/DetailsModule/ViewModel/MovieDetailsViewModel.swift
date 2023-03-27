//
//  DetailsViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol DetailsViewModelProtocol: AnyObject {
    var movieDetails: Movie? { get }
    var reload: (() -> ())? { get set }
    var networkService: NetworkServiceProtocol { get }
    var id: Int { get set }
    func fetchData(with id: Int)
}

class DetailsViewModel: DetailsViewModelProtocol {
    var id: Int
    var movieDetails: Movie?
    var reload: (() -> ())?
    var isLoading: Bool = false
    var networkService: NetworkServiceProtocol
    let dispatchGroup = DispatchGroup()
    
    init (id:Int, networkService: NetworkServiceProtocol) {
        self.id = id
        self.networkService = networkService
    }
    
    func fetchData(with id: Int)  {
        guard !isLoading else { return }
        isLoading = true
        networkService.fetchMovies(with: String(id), completion: { [weak self] result in
            guard let self = self  else { return }
            switch result {
            case .success(let movie):
            
            self.movieDetails = movie
                self.reload?()
            case .failure(let error):
                print (error)
            }
        })
    }
    
}

