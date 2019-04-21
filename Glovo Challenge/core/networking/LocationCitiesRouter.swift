//
//  LocationCitiesRouter.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/19/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

typealias Parameters = [String: Any]?

enum LocationCitiesRouter: URLRequestConvertible {
    case getCountries
    case getCities
    case getWorkingArea(code: String)
    
    var path: String {
        switch self {
        case .getCountries:
            return "countries"
        case .getCities:
            return "cities"
        case .getWorkingArea(let code):
            return "cities/\(code)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return request(path: path, method: .get)
    }
    
    private func request(path: String, method: HTTPMethod, parameters: Parameters=nil) -> URLRequest {
        let baseURL = ConfigurationUtils.value(from: .baseUrl)
        
        let url = URL(string: baseURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}
