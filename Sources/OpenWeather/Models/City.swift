//
//  City.swift
//  
//
//  Created by Ezequiel Becerra on 10/10/2022.
//

import Foundation

public struct City: Decodable {
    public let id: Int
    public let name: String
    public let coordinates: Coordinates
    public let sunrise: Date
    public let sunset: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinates = "coord"
        case sunrise
        case sunset
    }
}
