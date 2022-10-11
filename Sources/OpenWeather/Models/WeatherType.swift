//
//  WeatherType.swift
//
//
//  Created by Ezequiel Becerra on 10/10/2022.
//

import Foundation

public enum WeatherType: Decodable {
    case tornado
    case freezingRain
    case thunderstorm
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case fewClouds
    case scatteredClouds
    case clouds
    case unknown(name: String)

    public var emoji: String {
        switch self {
        case .tornado:
            return "🌪"
        case .freezingRain:
            return "🌨"
        case .thunderstorm:
            return "⛈"
        case .drizzle:
            return "🌧"
        case .rain:
            return "🌧"
        case .snow:
            return "❄️"
        case .atmosphere:
            return "🌫"
        case .clear:
            return "☀️"
        case .fewClouds:
            return "🌤"
        case .scatteredClouds:
            return "⛅️"
        case .clouds:
            return "☁️"
        case .unknown:
            return "❓"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case description
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let description = try container.decode(String.self, forKey: .description)

        switch id {
        case 781:
            self = .tornado

        case 511:
            self = .freezingRain

        case 200...299:
            self = .thunderstorm

        case 300...399:
            self = .drizzle

        case 500...599:
            self = .rain

        case 600...699:
            self = .snow

        case 700...799:
            self = .atmosphere

        case 800:
            self = .clear

        case 801:
            self = .fewClouds

        case 802...803:
            self = .scatteredClouds

        case 804...899:
            self = .clouds

        default:
            self = .unknown(name: description)
        }
    }
}
