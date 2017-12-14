import XCTest
@testable import PlayerControls

class FormatterTests: XCTestCase {
    func test() {
        //"returns 'm:ss' format"
        XCTAssertEqual(TimeFormatter.string(from: 10), "0:10")
        XCTAssertEqual(TimeFormatter.string(from: 60), "1:00")
        XCTAssertEqual(TimeFormatter.string(from: 65), "1:05")
        
        //"returns 'mm:ss' format"
        XCTAssertEqual(TimeFormatter.string(from: 3599), "59:59")
        XCTAssertEqual(TimeFormatter.string(from: 2100),"35:00")
        
        //"returns 'h:mm:ss' format"
        XCTAssertEqual(TimeFormatter.string(from: 3600), "1:00:00")
        XCTAssertEqual(TimeFormatter.string(from: Int(3600 + 2 * 60 + 2)), "1:02:02")

        //"returns 'hh:mm:ss' format"
        XCTAssertEqual(TimeFormatter.string(from: 3600 * 10), "10:00:00")
    }
}
