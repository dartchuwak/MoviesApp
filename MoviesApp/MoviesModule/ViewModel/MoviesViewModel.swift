//
//  ListModuleViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol MoviesViewModelProtocol: AnyObject {
    var movies: [Movie] { get set }
    var reload: (() -> ())? { get set }
    var networkService: NetworkServiceProtocol { get set }
    func numberOfItemsInSection() -> Int
    func viewModelForSelectedItem() -> DetailsViewModelProtocol?
    func selectRow(indexPath: IndexPath)
    func fetchMovies()
}


final class MoviesViewModel: MoviesViewModelProtocol {
    var networkService: NetworkServiceProtocol = NetworkService()
    private var selectedIndexPath: IndexPath?
    private var isLoading = false
    var movies: [Movie] = []
    var reload: (() -> ())?
    
    func numberOfItemsInSection() -> Int {
        return movies.count
    }
    
    func fetchMovies() {
        guard !isLoading else { return }
        isLoading = true
        networkService.fetchTop250Movies(completion: { [weak self] result in
            guard let self = self  else { return }
            switch result {
            case .success(let movies):
                self.movies = movies
                self.reload?()
                print(movies)
            case .failure(let error):
                print (error)
            }
        })
    }
    
    
    func viewModelForSelectedItem() -> DetailsViewModelProtocol? {
        guard let indexPath = selectedIndexPath else { return nil}
        return DetailsViewModel(id: movies[indexPath.row].id,  networkService: NetworkService())
    }

    func selectRow(indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}
