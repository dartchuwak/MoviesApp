//
//  ViewController.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private(set) var viewModel: DetailsViewModelProtocol
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var raceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lifeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var deathLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var quoteText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 24)
        textView.isEditable = false
        return textView
    }()
    
    lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.fetchData()
        setupBindables()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideElements()
        self.activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    private func setupBindables() {
        viewModel.reload = { [weak self] in
            guard let self = self else { return }
            guard let details = self.viewModel.characterDetails else { return }
            
            DispatchQueue.main.async {
                guard let quote = self.viewModel.quote else { return }
                self.quoteText.text = "\"\(quote.dialog ?? "")\""
                self.movieLabel.text = self.viewModel.movie
                self.genderLabel.text = details.gender
                self.raceLabel.text = details.race
                self.lifeLabel.text = self.viewModel.characterBirthDeath
                self.nameLabel.text = details.name.uppercased()
                self.showElements()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension DetailsViewController {
    
    private func hideElements() {
        lifeLabel.isHidden = true
        raceLabel.isHidden = true
        genderLabel.isHidden = true
        quoteText.isHidden = true
        movieLabel.isHidden = true
        nameLabel.isHidden = true
    }
    
    private  func showElements() {
        lifeLabel.isHidden = false
        raceLabel.isHidden = false
        genderLabel.isHidden = false
        quoteText.isHidden = false
        movieLabel.isHidden = false
        lifeLabel.isHidden = false
        raceLabel.isHidden = false
        genderLabel.isHidden = false
        quoteText.isHidden = false
        movieLabel.isHidden = false
        nameLabel.isHidden = false
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(lifeLabel)
        view.addSubview(deathLabel)
        view.addSubview(activityIndicator)
        view.addSubview(quoteText)
        view.addSubview(movieLabel)
        
        let raceStack = UIStackView(arrangedSubviews: [genderLabel, raceLabel])
        raceStack.translatesAutoresizingMaskIntoConstraints = false
        raceStack.spacing = 30
        view.addSubview(raceStack)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            lifeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            lifeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lifeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            raceStack.topAnchor.constraint(equalTo: lifeLabel.bottomAnchor, constant: 30),
            raceStack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            quoteText.topAnchor.constraint(equalTo: raceStack.bottomAnchor, constant: 50),
            quoteText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            quoteText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            quoteText.heightAnchor.constraint(equalToConstant: 200),
            movieLabel.topAnchor.constraint(equalTo: quoteText.bottomAnchor, constant: 24),
            movieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
