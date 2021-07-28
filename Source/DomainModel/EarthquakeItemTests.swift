import XCTest
@testable import EarthQuake

final class EarthquakeItemTests: XCTestCase {

    func testEarthquakeItemFromEarthquakeHasExpectedProperties() {
        let earthquakeData = Earthquake(eqid: "1234", datetime: "2020-08-11", depth: 10.3, lat: 11.14, lng: 50.33, magnitude: 8.5)

        let sut = EarthquakeItem(earthQuake: earthquakeData)

        XCTAssertEqual(sut.identifier, "1234")
        XCTAssertEqual(sut.magnitude,"8.5")
        XCTAssertEqual(sut.magnitudeClass, .strong)
        XCTAssertEqual(sut.radiusInMeters, 10300)
    }

    func testEarthquakeItemFromEarthquakeHasNormalMagnitudeClassForDataWithMagnitudeLessThan8() {
        let earthquakeData = Earthquake(eqid: "1234", datetime: "2020-08-11", depth: 10.3, lat: 11.14, lng: 50.33, magnitude: 7.9)

        let sut = EarthquakeItem(earthQuake: earthquakeData)

        XCTAssertEqual(sut.magnitudeClass, .normal)

    }
}
