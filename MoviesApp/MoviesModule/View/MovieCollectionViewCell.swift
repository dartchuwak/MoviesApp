//
//  CollectionViewCell.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Harry Potter"
        label.numberOfLines = 3
        return label
    }()
    
    let engNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Harry Potter"
        label.numberOfLines = 3
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.text = "Harry Potter"
        label.numberOfLines = 3
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.text = "8.5"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(engNameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(detailsLabel)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            posterImage.widthAnchor.constraint(equalToConstant: 90),
            posterImage.heightAnchor.constraint(equalToConstant: 135),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            engNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            engNameLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            engNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailsLabel.topAnchor.constraint(equalTo: engNameLabel.bottomAnchor, constant: 8),
            detailsLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 14 ),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        backgroundColor = .white
        self.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: CellViewModelProtocol) {
        nameLabel.text = viewModel.movie.name
        posterImage.sd_setImage(with: viewModel.imageUrl)
        ratingLabel.text = viewModel.rating
        nameLabel.text = viewModel.movie.name
        engNameLabel.text = viewModel.engNameText
        detailsLabel.text = viewModel.detailsLabel
        
    }
}

