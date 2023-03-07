//
//  AppCoordinator.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 05.03.2023.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start()
    func finish()
}

class AppCoordinator: CoordinatorProtocol {
    
    private let window: UIWindow?
    private let appDependency: AppDependency

    lazy var rootViewController: UITabBarController = {
        let tb = UITabBarController()
        let characterVC = CharactersViewController(viewModel: appDependency.charactersViewModel)
        characterVC.navigationItem.title = Localize.characters
        characterVC.tabBarItem = UITabBarItem(title: "Персонажи", image: UIImage(systemName: "circle"), tag: 0)
        characterVC.tabBarController?.tabBar.tintColor = .brown
        let characterNavController = UINavigationController(rootViewController: characterVC)
        characterNavController.navigationBar.prefersLargeTitles = true
        let vc = ViewController()
        vc.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "square"), tag: 1)
        vc.tabBarController?.tabBar.tintColor = .brown
        tb.tabBar.backgroundColor = .white
        
        tb.setViewControllers([characterNavController, vc], animated: true)
        return tb
        }()
    
    
    init(window: UIWindow?, appDependency: AppDependency) {
        self.window = window
        self.appDependency = appDependency
    }

    
    func start() {
        guard let window = window else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func finish() {
    }
 
}


