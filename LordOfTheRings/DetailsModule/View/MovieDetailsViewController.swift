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
        return label
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
    }
    
    private func setupBindables() {
        viewModel.reload = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
       
                self?.nameLabel.text = self?.viewModel.movieDetails?.name
            }
        }
    }
}

extension DetailsViewController {
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
        ])
    }
}
