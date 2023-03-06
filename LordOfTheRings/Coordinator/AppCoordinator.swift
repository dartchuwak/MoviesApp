//
//  AppCoordinator.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 05.03.2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    
    
    
    lazy var rootViewController: UINavigationController = {
           return UINavigationController(rootViewController: ListModuleViewController())
       }()
    
    
    init(window: UIWindow?) {
           self.window = window
       }
    
    override func start() {
           guard let window = window else {
               return
           }

           window.rootViewController = ListModuleViewController()
           window.makeKeyAndVisible()
       }
}
