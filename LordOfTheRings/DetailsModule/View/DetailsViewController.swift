//
//  ViewController.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private(set) var viewModel: DetailsViewModelProtocol
    
    lazy var ActivityInocator: UIActivityIndicatorView = {
        let aa = UIActivityIndicatorView()
        aa.translatesAutoresizingMaskIntoConstraints = false
        return aa
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        label.font = .boldSystemFont(ofSize: 30)
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
    
    lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some text"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 24)
        return label
    }()
    
    lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some text"
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
        self.ActivityInocator.startAnimating()
        self.nameLabel.text = self.viewModel.characterData?.name.uppercased()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    private func setupBindables() {
        viewModel.reload = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                guard let quote = self.viewModel.quote else { return }
                self.quoteLabel.text = "\"\(quote.dialog!)\""
                self.movieLabel.text = self.viewModel.movie
                self.genderLabel.text = self.viewModel.characterDetails?.gender
                self.raceLabel.text = self.viewModel.characterDetails?.race
                self.lifeLabel.text = self.viewModel.characterBirthDeath
                self.showElements()
                self.ActivityInocator.stopAnimating()
            }
        }
    }
}

extension DetailsViewController {
    
    private func hideElements() {
        lifeLabel.isHidden = true
        raceLabel.isHidden = true
        genderLabel.isHidden = true
        quoteLabel.isHidden = true
        movieLabel.isHidden = true
    }
    
    private  func showElements() {
        
        lifeLabel.isHidden = false
        raceLabel.isHidden = false
        genderLabel.isHidden = false
        quoteLabel.isHidden = false
        movieLabel.isHidden = false
        lifeLabel.isHidden = false
        raceLabel.isHidden = false
        genderLabel.isHidden = false
        quoteLabel.isHidden = false
        movieLabel.isHidden = false
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(genderLabel)
        view.addSubview(raceLabel)
        view.addSubview(lifeLabel)
        view.addSubview(deathLabel)
        view.addSubview(ActivityInocator)
        
        let quoteStack = UIStackView(arrangedSubviews: [quoteLabel, movieLabel])
        quoteStack.translatesAutoresizingMaskIntoConstraints = false
        quoteStack.axis = .vertical
        quoteStack.spacing = 30
        view.addSubview(quoteStack)
        
        let raceStack = UIStackView(arrangedSubviews: [genderLabel, raceLabel])
        raceStack.translatesAutoresizingMaskIntoConstraints = false
        raceStack.spacing = 30
        view.addSubview(raceStack)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lifeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            lifeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lifeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            raceStack.topAnchor.constraint(equalTo: lifeLabel.bottomAnchor, constant: 30),
            raceStack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            quoteStack.topAnchor.constraint(equalTo: raceStack.bottomAnchor, constant: 50),
            quoteStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quoteStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            quoteStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ActivityInocator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ActivityInocator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
