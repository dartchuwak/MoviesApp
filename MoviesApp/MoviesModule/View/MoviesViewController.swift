//
//  CollectionViewController.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

protocol ListModuleViewControllerProtocol: AnyObject {
    var viewModel: MoviesViewModelProtocol { get set }
}

class MoviesViewController: UIViewController, ListModuleViewControllerProtocol, UISearchBarDelegate {
    
    var viewModel: MoviesViewModelProtocol
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    var timer = Timer()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: MoviesViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        setupBindables()
        setupSearchBar()
        viewModel.loadLocalMovies()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self]  _ in
            guard let self = self else { print("ERROR!"); return}
            print(searchText)
            self.viewModel.searchMovies(with: searchText)
        })
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        searchController.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharactersCollectionViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.posterImage.sd_setImage(with: URL(string:movie.poster.previewUrl))
        cell.ratingLabel.text = "\(movie.rating.kp)"
        cell.nameLabel.text = movie.name
        cell.engNameLabel.text = "\(movie.alternativeName ?? ""), \(movie.year)"
        let ganresArray = movie.genres.map{$0.name}
        cell.detailsLabel.text = "\(movie.countries.first!.name), \(ganresArray.joined(separator: ", "))"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectRow(indexPath: indexPath)
        guard let detailsViewModel = viewModel.viewModelForSelectedItem() else { return }
        let vc = DetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
        private func setupBindables() {
            viewModel.reload = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 135)
    }
}
