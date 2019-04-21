//
//  MainViewModel.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/21/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func didShowError(error: Error)
}

class MainViewModel {
    
    private let citiesService = CitiesService()
    private let workingAreaService = WorkingAreaService()
    
    weak var delegate: MainViewModelDelegate?
    
    var cities: CitiesArray!
    var cityWorkingArea = [String]() {
        didSet {
            updatedWorkingArea()
        }
    }
    
    var updatedWorkingArea: () -> () = {}
    
    func getCities() {
        citiesService.getCities { [weak self] response in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let response):
                strongSelf.cities = response
            case .failure(let error):
                strongSelf.delegate?.didShowError(error: error)
            }
        }
    }
    
    func fetchWorkingArea(city: City) {
        workingAreaService.getCity(code: city.code) { [weak self] response in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let response):
                strongSelf.cityWorkingArea = response.workingArea
            case .failure(let error):
                strongSelf.delegate?.didShowError(error: error)
            }
        }
    }
    
    func city(code: String) -> City {
        let results = self.cities.filter {$0.code == code}
        return results.first!
    }
    
    func isCityIntoWorkinArea(code: String) -> Bool {
        return self.cities.filter {$0.code == code}.count > 0 ? true : false
    }
}
