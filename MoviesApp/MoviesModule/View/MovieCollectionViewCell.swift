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
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.widthAnchor.constraint(equalToConstant: 180),
            posterImage.heightAnchor.constraint(equalToConstant: 270),
            posterImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

