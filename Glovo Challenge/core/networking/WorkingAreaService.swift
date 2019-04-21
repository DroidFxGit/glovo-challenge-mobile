//
//  WorkingAreaService.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/21/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

class WorkingAreaService: BaseService<City> {
    
    func getCity(code: String, completion: @escaping completionHandler<City>) {
        guard let request = try? LocationCitiesRouter.getWorkingArea(code: code).asURLRequest() else {
            completion(.failure(error: ServiceError.badrequest))
            return
        }
        perform(request: request, completion: completion)
    }
}
