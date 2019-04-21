//
//  URLRequestConvertible.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/19/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}
