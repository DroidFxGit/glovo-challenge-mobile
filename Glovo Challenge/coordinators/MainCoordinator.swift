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
        mainViewController.title = "Main Screen"
        mainViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    fileprivate func presentPickerView(from view: UIViewController) {
        let pickerView = PickerCityViewController()
        pickerView.title = "Choose your City"
        
        let navigationController = UINavigationController(rootViewController: pickerView)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        
        view.present(navigationController, animated: true, completion: nil)
    }
}

extension MainCoordinator: MainViewControllerDelegate {
    func didShowCitiesScreen(view: UIViewController) {
        DispatchQueue.main.async {
            self.presentPickerView(from: view)
        }
    }
    
    func didShowMapScreen(view: UIViewController) {
        
    }
}
