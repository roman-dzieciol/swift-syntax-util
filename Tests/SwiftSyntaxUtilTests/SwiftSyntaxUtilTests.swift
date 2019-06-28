import XCTest
@testable import SwiftSyntaxUtil

final class SwiftSyntaxUtilTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftSyntaxUtil().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
