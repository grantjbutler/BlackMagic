import XCTest
@testable import BlackMagic

final class BlackMagicTests: XCTestCase {
    func testExample() {
        XCTAssertTrue(BMDIsSDKInstalled())
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
