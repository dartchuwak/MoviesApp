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
        let moviesVC = MoviesViewController(viewModel: appDependency.moviesViewModel)
        moviesVC.navigationItem.title = Localize.movies
        let moviesNavController = UINavigationController(rootViewController: moviesVC)
        return moviesNavController
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


