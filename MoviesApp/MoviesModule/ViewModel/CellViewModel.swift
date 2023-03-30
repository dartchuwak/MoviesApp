//
//  CellViewModel.swift
//  MoviesApp
//
//  Created by Evgenii Mikhailov on 28.03.2023.
//

import Foundation

protocol CellViewModelProtocol {
    var movie: Movie { get }
    var imageUrl: URL? { get }
    var rating: String? { get }
    var engNameText: String? { get  }
    var detailsLabel: String? { get }
}

final class CellViewModel: CellViewModelProtocol {
    
    var movie: Movie
    var imageUrl: URL?
    var rating: String?
    var engNameText: String?
    var detailsLabel: String?
    
    init (movie: Movie) {
        self.movie = movie
        prepareData()
    }
    
    private func prepareData() {
        guard let imageUrl = URL(string: movie.poster.previewUrl) else { return }
        self.imageUrl = imageUrl
        let rating = String(movie.rating.kp)
        self.rating = String(rating.prefix(3))
        let text = "\(movie.alternativeName ?? ""), \(movie.year)"
        self.engNameText = text
        let ganresArray = movie.genres.map{$0.name}
        self.detailsLabel = "\(movie.countries.first?.name ?? ""), \(ganresArray.joined(separator: ", "))"
    }
}
