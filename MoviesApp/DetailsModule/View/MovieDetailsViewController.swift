//
//  ViewController.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private(set) var viewModel: DetailsViewModelProtocol
    
    lazy var scrollView: UIScrollView =  {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    lazy var votesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    lazy var englishNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        return label
    }()
    
    lazy var castLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    lazy var infoVStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.alignment = .center
        vStack.backgroundColor = .orange
        vStack.distribution = .fillEqually
        return vStack
    }()
   
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let ganreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupBindables()
        viewModel.fetchMovieDeatails(with: viewModel.id)
       // viewModel.loadLocalMovieDeatails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setUpView()
        self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    private func setupBindables() {
        viewModel.reload = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let movie = self.viewModel.movie else { return }
                self.posterImage.sd_setImage(with: URL(string: (movie.poster.url)))
                self.nameLabel.text = movie.name
                self.ratingLabel.text = self.viewModel.rating
                self.votesLabel.text = self.viewModel.votes
                self.detailsLabel.text = self.viewModel.details
                self.englishNameLabel.text = movie.alternativeName
                self.shortDescriptionLabel.text = movie.shortDescription
                self.descriptionLabel.text = movie.description
                self.castLabel.text = self.viewModel.personsString
            }
        }
    }
}

extension DetailsViewController {
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(posterImage)
        contentView.addSubview(shortDescriptionLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(infoVStack)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(castLabel)
        
        infoVStack.addArrangedSubview(ratingLabel)
        infoVStack.addArrangedSubview(votesLabel)
      //  infoVStack.addArrangedSubview(englishNameLabel)
        
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width) / 1.5),
            posterImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoVStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            infoVStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoVStack.widthAnchor.constraint(equalToConstant: 100),
            detailsLabel.topAnchor.constraint(equalTo: infoVStack.bottomAnchor, constant: 16),
            detailsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            detailsLabel.widthAnchor.constraint(equalToConstant: 250),
            
            castLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 16),
            castLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            castLabel.widthAnchor.constraint(equalToConstant: 250),
            
            shortDescriptionLabel.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 16),
            shortDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shortDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
        ])
    }
}
