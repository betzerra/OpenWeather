//
//  Forecast.swift
//  
//
//  Created by Ezequiel Becerra on 10/10/2022.
//

import Foundation

public struct Forecast: Decodable {
    public let city: City
    public let list: [WeatherEntry]
}
