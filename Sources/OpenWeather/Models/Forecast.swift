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

    var minimum: WeatherEntry? {
        list.min { lhs, rhs in
            lhs.minimum < rhs.minimum
        }
    }

    var maximum: WeatherEntry? {
        list.max { lhs, rhs in
            lhs.maximum < rhs.maximum
        }
    }

    /// Groups weather entries by a temperature threshold
    public func cluster(by threshold: Float) -> [WeatherEntry] {
        var cluster = [WeatherEntry]()

        guard var last = list.first else {
            return []
        }

        cluster.append(last)

        list.forEach { item in
            if abs(item.temperature - last.temperature) > threshold {
                last = item
                cluster.append(item)
            }
        }
        return cluster
    }
}
