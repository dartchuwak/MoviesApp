//
//  CollectionViewCell.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit

class ListModuleCollectionViewCell: UICollectionViewCell {
        
        let titleLabel = UILabel()
       // let subtitleLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = .black
            contentView.addSubview(titleLabel)
            
//            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
//            subtitleLabel.font = UIFont.systemFont(ofSize: 12)
//            subtitleLabel.textColor = .gray
//            contentView.addSubview(subtitleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//                subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//                subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            ])
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
//        func configureCell(title: String, subtitle: String, image: UIImage) {
//            titleLabel.text = title
//            subtitleLabel.text = subtitle
//            imageView.image = image
//        }
    }

