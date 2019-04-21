//
//  CountriesService.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/21/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

typealias CountriesArray = [Country]

class CountriesService: BaseService<CountriesArray> {
    
    func getCountries(_ completion: @escaping completionHandler<CountriesArray>) {
        guard let request = try? LocationCitiesRouter.getCountries.asURLRequest() else {
            completion(.failure(error: ServiceError.badrequest))
            return
        }
        perform(request: request, completion: completion)
    }
}
