//
//  MainViewModel.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/21/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

class MainViewModel {
    
    private let citiesService = CitiesService()
    private let workingAreaService = WorkingAreaService()
    
    var cities: CitiesArray!
    var cityWorkingArea = [String]() {
        didSet {
            updatedWorkingArea()
        }
    }
    
    var updatedWorkingArea: () -> () = {}
    
    func getCities() {
        citiesService.getCities { response in
            switch response {
            case .success(let response):
                self.cities = response
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func fetchWorkingArea(city: City) {
        workingAreaService.getCity(code: city.code) { response in
            switch response {
            case .success(let response):
                self.cityWorkingArea = response.workingArea
            case .failure(let error):
                print("\(error)")
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
