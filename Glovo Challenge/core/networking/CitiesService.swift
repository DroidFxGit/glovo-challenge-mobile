//
//  CitiesService.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/21/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

typealias CitiesArray = [City]

class CitiesService: BaseService<CitiesArray> {
    
    func getCities(_ completion: @escaping completionHandler<CitiesArray>) {
        guard let request = try? LocationCitiesRouter.getCities.asURLRequest() else {
            completion(.failure(error: ServiceError.badrequest))
            return
        }
        perform(request: request, completion: completion)
    }
}
