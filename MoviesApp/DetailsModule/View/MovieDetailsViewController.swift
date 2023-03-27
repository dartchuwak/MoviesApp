//
//  ViewController.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private(set) var viewModel: DetailsViewModelProtocol
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupBindables()
        viewModel.fetchData(with: viewModel.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        view.backgroundColor = .black
    }
    
    private func setupBindables() {
        viewModel.reload = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                self?.nameLabel.text = self?.viewModel.movieDetails?.title
                self?.posterImage.sd_setImage(with: URL(string: (self?.viewModel.movieDetails!.image)!))
            }
        }
    }
}

extension DetailsViewController {
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(posterImage)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            posterImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width) / 0.667),
            posterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
