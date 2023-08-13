//
//  DetailsViewModel.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import Foundation


protocol DetailsViewModelProtocol: AnyObject {
    var movie: Movie? { get }
    var reload: (() -> ())? { get set }
    var networkService: NetworkServiceProtocol { get }
    var id: Int { get }
    var details: String? { get }
    var rating: String? { get }
    var votes: String? { get }
    var personsString: String? { get }
    func fetchMovieDeatails(with id: Int)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    var id: Int
    var movie: Movie?
    var reload: (() -> ())?
    var isLoading: Bool = false
    var networkService: NetworkServiceProtocol
    var details: String?
    var rating: String?
    var votes: String?
    var personsString: String?
    
    init (id: Int , networkService: NetworkServiceProtocol) {
        self.id = id
        self.networkService = networkService
        fetchMovieDeatails(with: id)
    }
    
    func fetchMovieDeatails(with id: Int)  {
        guard !isLoading else { return }
        isLoading = true
        Task {
            
            let result = await networkService.fetchMovieDetails(with: String(id))
            
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.movie = movie
                    self.prepareData(movie: movie)
                    self.reload?()
                }
            case .failure(let error):
                print (error)
                
            }
        }
    }
}
    
    extension DetailsViewModel {
        
        private func prepareData(movie: Movie) {
            let ganresArray = movie.genres.map{$0.name}
            details = "\(movie.year), \((ganresArray.joined(separator: ", ")))"
            let rating = String(movie.rating.kp).prefix(3)
            self.rating = String(rating)
            self.votes = convertToKFormat(number: movie.votes.kp)
            self.personsString = preparePersonsString(movie: movie)
        }
        
        private func preparePersonsString(movie: Movie) -> String {
            guard let persons = movie.persons else { return "В ролях: "}
            let personsArray = persons.compactMap{$0.name}
            let personsString = "В ролях: \(personsArray.joined(separator: ", "))"
            return personsString
        }
        
    }
    
