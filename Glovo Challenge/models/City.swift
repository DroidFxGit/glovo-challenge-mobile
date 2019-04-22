//
//  City.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/20/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation

struct City: Codable {
    var code: String
    var name: String
    var countryCode: String
    var currency: String?
    var enabled: Bool?
    var busy: Bool?
    var timeZone: String?
    var languageCode: String?
    var workingArea: [String]
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case countryCode = "country_code"
        case currency
        case enabled
        case busy
        case timeZone = "time_zone"
        case languageCode = "language_code"
        case workingArea = "working_area"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        countryCode = try container.decode(String.self, forKey: .countryCode)
        workingArea = try container.decode([String].self, forKey: .workingArea)
        
        //optional values
        do {
            currency = try container.decode(String.self, forKey: .currency)
            enabled = try container.decode(Bool.self, forKey: .enabled)
            busy = try container.decode(Bool.self, forKey: .busy)
            timeZone = try container.decode(String.self, forKey: .timeZone)
            languageCode = try container.decode(String.self, forKey: .languageCode)
        } catch {
            currency = nil
            enabled = nil
            busy = nil
            timeZone = nil
            languageCode = nil
        }
    }
}
