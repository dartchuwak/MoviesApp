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
    
    lazy var rootViewController: UIViewController = {
        let characterVC = CharactersViewController(viewModel: appDependency.charactersViewModel)
        characterVC.navigationItem.title = Localize.characters
        characterVC.tabBarController?.tabBar.tintColor = .brown
        let characterNavController = UINavigationController(rootViewController: characterVC)
        characterNavController.navigationBar.prefersLargeTitles = true
        return characterNavController
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


