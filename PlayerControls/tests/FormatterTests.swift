import Quick
import Nimble

@testable import PlayerControls

class FormatterTests: QuickSpec {
    override func spec() {
        describe("Formatter") {
            it ("returns 'm:ss' format") {
                expect(TimeFormatter.string(from: 10)) == "0:10"
                expect(TimeFormatter.string(from: 60)) == "1:00"
                expect(TimeFormatter.string(from: 65)) == "1:05"
            }
            it ("returns 'mm:ss' format") {
                expect(TimeFormatter.string(from: 3599)) == "59:59"
                expect(TimeFormatter.string(from: 2100)) == "35:00"
            }
            
            it ("returns 'h:mm:ss' format") {
                expect(TimeFormatter.string(from: 3600)) == "1:00:00"
                expect(TimeFormatter.string(from: UInt(3600 + 2 * 60 + 2))) == "1:02:02"
            }
            
            it ("returns 'hh:mm:ss' format") {
                expect(TimeFormatter.string(from: 3600 * 10)) == "10:00:00"
            }
        }
    }
}
