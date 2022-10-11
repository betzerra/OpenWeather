import Foundation
import Pluma

public class OpenWeather {
    let token: String
    let pluma: Pluma

    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    public init(token: String, baseURL: URL?) {
        self.token = token

        let url = baseURL ?? OpenWeather.defaultBaseURL
        pluma = Pluma(baseURL: url, decoder: OpenWeather.decoder)
    }

    init(token: String, client: APIClient) {
        self.token = token
        pluma = Pluma(client: client, decoder: OpenWeather.decoder)
    }

    public func forecast(
        latitude: Double,
        longitude: Double
    ) async throws -> Forecast {
        try await pluma.request(
            method: .GET,
            path: "forecast",
            params: [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
                "APPID": token,
                "units": "metric"
            ]
        )
    }

    private static var defaultBaseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5") else {
            fatalError("Fatal error getting defaultBaseURL")
        }
        return url
    }
}
