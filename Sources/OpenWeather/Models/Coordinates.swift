//
//  Coordinates.swift
//  
//
//  Created by Ezequiel Becerra on 10/10/2022.
//

import Foundation

public struct Coordinates: Codable {
    let latitude: Float
    let longitude: Float

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
