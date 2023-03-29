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
    var reloadScreens: (() -> ())? { get set }
    var id: Int { get set }
    var details: String? { get }
    var rating: String? { get }
    var votes: String? { get }
    var personsString: String? { get }
    func fetchMovieDeatails(with id: Int)
    //func loadLocalMovieDeatails()
}

class DetailsViewModel: DetailsViewModelProtocol {
    var id: Int
    var movie: Movie?
    var screenshots: [Screenshot] = []
    var reload: (() -> ())?
    var reloadScreens: (() -> ())? 
    var isLoading: Bool = false
    var networkService: NetworkServiceProtocol
    var details: String?
    var rating: String?
    var votes: String?
    var personsString: String?
    
    
    init (id: Int , networkService: NetworkServiceProtocol) {
        self.id = id
        self.networkService = networkService
    }
    
    func fetchMovieDeatails(with id: Int)  {
        guard !isLoading else { return }
        isLoading = true
        networkService.fetchMovieDetails(with: String(id), completion: { [weak self] result in
            guard let self = self  else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.prepareData(movie: movie)
                self.reload?()
            case .failure(let error):
                print (error)
            }
        })
    }
    
    
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
    
    func convertToKFormat(number: Int) -> String {
        let num = Double(number)
        let sign = ((num < 0) ? "-" : "" )
        let absNum = fabs(num)
        if absNum < 1000.0 {
            return "\(sign)\(Int(absNum))"
        }
        let exp = Int(log10(absNum) / 3.0 ) // power of 1000
        let units = ["K", "M", "B", "T", "P", "E"]
        let roundedNum = round(10 * absNum / pow(1000.0, Double(exp))) / 10
        return "\(sign)\(Int(roundedNum * 10) / 10)\(units[exp-1])"
    }
    
    func loadLocalMovieDeatails()  {
        guard !isLoading else { return }
        isLoading = true
        networkService.loadLocalMoviesDetails { [weak self] result in
            guard let self = self  else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.reload?()
                self.isLoading = false
            case .failure(let error):
                print (error)
            }
        }
    }

}

