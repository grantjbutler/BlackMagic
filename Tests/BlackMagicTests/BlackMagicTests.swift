import XCTest
@testable import BlackMagic

final class BlackMagicTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BlackMagic().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
