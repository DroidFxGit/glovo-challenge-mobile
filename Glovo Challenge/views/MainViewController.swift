//
//  MainViewController.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/19/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func didShowCitiesScreen()
    func didShowMapScreen()
}

class MainViewController: UIViewController {

    weak var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func permissionButton(_ sender: UIButton) {
        
    }
    
}
