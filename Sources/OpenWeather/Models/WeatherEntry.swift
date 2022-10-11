//
//  WeatherEntry.swift
//  
//
//  Created by Ezequiel Becerra on 10/10/2022.
//

import Foundation

public struct WeatherEntry: Decodable {
    public let date: Date

    public let temperature: Float
    public let feelsLike: Float
    public let minimum: Float
    public let maximum: Float

    public let type: WeatherType

    enum RootCodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case type = "weather"

        enum MainCodingKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feels_like"
            case minimum = "temp_min"
            case maximum = "temp_max"
        }
    }

    public init(from decoder: Decoder) throws {
        // Root
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        date = try rootContainer.decode(Date.self, forKey: .date)
        let types = try rootContainer.decode([WeatherType].self, forKey: .type)
        type = types.first ?? .unknown(name: "N/A")

        // Main
        let mainContainer = try rootContainer.nestedContainer(
            keyedBy: RootCodingKeys.MainCodingKeys.self,
            forKey: .main
        )

        temperature = try mainContainer.decode(Float.self, forKey: .temperature)
        feelsLike = try mainContainer.decode(Float.self, forKey: .feelsLike)
        minimum = try mainContainer.decode(Float.self, forKey: .minimum)
        maximum = try mainContainer.decode(Float.self, forKey: .maximum)
    }
}
