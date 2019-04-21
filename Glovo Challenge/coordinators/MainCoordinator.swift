//
//  MainCoordinator.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/19/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Startable {
    
    fileprivate weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        configureMainViewController()
    }
    
    fileprivate func configureMainViewController() {
        let mainViewController = MainViewController()
        mainViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.navigationBar.isHidden = true
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension MainCoordinator: MainViewControllerDelegate {
    func didShowCitiesScreen(view: UIViewController) {
        
    }
    
    func didShowMapScreen(view: UIViewController) {
        
    }
}
