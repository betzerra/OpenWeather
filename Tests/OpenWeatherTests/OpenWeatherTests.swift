import XCTest
@testable import OpenWeather
@testable import Pluma

final class OpenWeatherTests: XCTestCase {
    func testExample() throws {
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
}
