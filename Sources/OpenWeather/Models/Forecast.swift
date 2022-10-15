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

    public var minimum: WeatherEntry? {
        list.min { lhs, rhs in
            lhs.minimum < rhs.minimum
        }
    }

    public var maximum: WeatherEntry? {
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
            // Add a new weather entry if:
            // 1. The temperature is significant different or...
            // 2. The weather type is different (clear, rain, snow, clouds, etc)
            if abs(item.temperature - last.temperature) > threshold ||
                item.type != last.type {

                last = item
                cluster.append(item)
            }
        }
        return cluster
    }
}
