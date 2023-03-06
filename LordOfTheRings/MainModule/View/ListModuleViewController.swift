//
//  CollectionViewController.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 04.03.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol ListModuleViewControllerProtocol: AnyObject {
    var viewModel: ListModuleViewModelProtocol? { get set }
   // var appCoordinator: CoordinatorProtocol? { get set }
}



class ListModuleViewController: UIViewController, ListModuleViewControllerProtocol {
    
    var viewModel: ListModuleViewModelProtocol? // Хорошо бы использовать DI
    //var appCoordinator: AppCoordinator?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cyan
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListModuleViewModel() // Хорошо бы использовать DI
        view.backgroundColor = .orange
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.register(ListModuleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel!.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}


extension ListModuleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel!.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListModuleCollectionViewCell
        guard let viewModel = viewModel else { return UICollectionViewCell()}
        let character = viewModel.characters[indexPath.item]
        cell.backgroundColor = .red
        cell.titleLabel.text = character.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(indexPath: indexPath)
        let vc = DetailsViewController()
        vc.viewModel = viewModel.viewModelForSelectedItem()
        present(vc, animated: true)
    }
}

extension ListModuleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 20, height: 50)
    }
}
