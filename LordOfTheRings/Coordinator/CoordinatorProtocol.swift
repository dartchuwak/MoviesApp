//
//  CoordinatorProtocol.swift
//  LordOfTheRings
//
//  Created by Evgenii Mikhailov on 05.03.2023.
//

import Foundation
import UIKit


protocol CoordinatorProtocol: AnyObject {
//    var parentCoordinator: CoordinatorProtocol? { get set }
//    var children: [CoordinatorProtocol] { get set }
//    var navigationController : UINavigationController { get set }
    func start()
    func finish()
}
