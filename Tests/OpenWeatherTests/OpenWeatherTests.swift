import XCTest
@testable import OpenWeather
@testable import Pluma

final class OpenWeatherTests: XCTestCase {
    func testParsing() throws {
        let client = MockClient(bundle: Bundle.module)
        let service = OpenWeather(token: "abc123", client: client)

        let expectation = expectation(description: "Get forecast request")

        Task.init {
            let forecast: Forecast = try await service.forecast(
                latitude: -34.586217,
                longitude: -58.477769
            )

            XCTAssertEqual(forecast.city.id, 3427387)
            XCTAssertEqual(forecast.city.name, "Villa Ortúzar")
            XCTAssertEqual(forecast.list.count, 40)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testCluster() throws {
        let client = MockClient(bundle: Bundle.module)
        let service = OpenWeather(token: "abc123", client: client)

        let expectation = expectation(description: "Get forecast request")

        Task.init {
            let forecast: Forecast = try await service.forecast(
                latitude: -34.586217,
                longitude: -58.477769
            )

            let tempsExpectation: [Float] = [
                18.8,
                12.67,
                17.81,
                12.65,
                25.02,
                19.06,
                12.89,
                18.62,
                12.28
            ]

            let cluster = forecast.cluster(by: 5).map { $0.temperature }
            XCTAssertEqual(cluster, tempsExpectation)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)

    }
}
