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
    private let appDependency: AppDependencyProtocol
    
    lazy var rootViewController: UINavigationController = {
        let characterVC = MoviesViewController(viewModel: appDependency.moviesViewModel)
        characterVC.navigationItem.title = Localize.movies
        let characterNavController = UINavigationController(rootViewController: characterVC)
        return characterNavController
    }()
    
    
    init(window: UIWindow?, appDependency: AppDependencyProtocol) {
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


