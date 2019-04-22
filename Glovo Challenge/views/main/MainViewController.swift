//
//  MainViewController.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/19/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import UIKit
import MapKit
import PKHUD

protocol MainViewControllerDelegate: class {
    func didShowCitiesScreen(view: UIViewController)
    func didShowMapScreen(view: UIViewController)
}

class MainViewController: UIViewController, CardViewPresentable {

    @IBOutlet weak var mapView: MKMapView!
    
    private let locationService = LocationService()
    weak var delegate: MainViewControllerDelegate?
    var cardViewController = CardViewController(nibName:"CardViewController", bundle:nil)
    
    lazy var viewModel: MainViewModel = {
        let vm = MainViewModel()
        vm.delegate = self
        return vm
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCardView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        HUD.show(.progress)
        
        locationService.updatedCoordinates = { [weak self] authorized in
            guard let strongSelf = self else { return }
            if !authorized {
                strongSelf.delegate?.didShowCitiesScreen(view: strongSelf)
                return
            }
        }
        
        viewModel.updatedCities = {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                print("\(String(describing: strongSelf.viewModel.cities))")
                strongSelf.getAddress()
            }
        }
        viewModel.getCities()
    }
    
    func getAddress() {
        locationService.getAddress({ (placeMark, error) in
            if let placeMark = placeMark {
                print(placeMark)
            }
        })
    }
}

extension MainViewController: MainViewModelDelegate {
    func didShowError(error: Error) {
//        HUD.flash(.error, delay: 0.5)
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return MKAnnotationView()
    }
}
