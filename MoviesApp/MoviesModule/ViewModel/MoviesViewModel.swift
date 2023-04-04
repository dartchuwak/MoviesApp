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
    var movieRating: String? { get set }
    func numberOfItemsInSection() -> Int
    func viewModelForSelectedItem() -> DetailsViewModelProtocol?
    func selectRow(indexPath: IndexPath)
    func fetchMovies()
    func searchMovies(with text: String)
}

final class MoviesViewModel: MoviesViewModelProtocol {
    var networkService: NetworkServiceProtocol = NetworkService()
    private var selectedIndexPath: IndexPath?
    private var isLoading = false
    var movies: [Movie] = []
    var reload: (() -> ())?
    var movieRating: String?
    
    func numberOfItemsInSection() -> Int {
        return movies.count
    }
    
    func fetchMovies() {
        Task.init {
            guard !isLoading else { return }
            isLoading = true
            
            let result = await networkService.fetchMovies()
            
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies = movies
                    self.isLoading = false
                    self.reload?()
                }
            case .failure(let error):
                print ("Error: \(error)")
            }
            
        }
    }
    
    func searchMovies(with text: String ) {
        guard !isLoading else { return }
        isLoading = true
        Task {
            let result = await networkService.searchMovies(with: text)
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies = movies
                    self.isLoading = false
                    self.reload?()
                }
            case .failure(let error):
                print ("Error: \(error)")
            }
        }
    }
    
    func viewModelForSelectedItem() -> DetailsViewModelProtocol? {
        guard let indexPath = selectedIndexPath else { return nil }
        return DetailsViewModel(id: movies[indexPath.row].id,  networkService: NetworkService())
    }
    
    func selectRow(indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
