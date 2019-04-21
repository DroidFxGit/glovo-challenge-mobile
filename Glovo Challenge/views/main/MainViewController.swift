//
//  MainViewController.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/19/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func didShowCitiesScreen(view: UIViewController)
    func didShowMapScreen(view: UIViewController)
}

class MainViewController: UIViewController {

    private let locationService = LocationService()
    weak var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.updatedCoordinates = { [weak self] authorized in
            guard let strongSelf = self else { return }
            if authorized {
                strongSelf.getAddress()
            } else {
                strongSelf.delegate?.didShowCitiesScreen(view: strongSelf)
            }
        }
    }
    
    func getAddress() {
        locationService.getAddress({ (placeMark, error) in
            if let placeMark = placeMark {
                print(placeMark)
            }
        })
    }
}
