import VASTParser
import XCTest

class ErrorLogTests: XCTestCase {
    func test_init_hasNoItemsAtStart() {
        let errorLog = VAST.Parsing.ErrorLog()
        XCTAssertEqual(errorLog.items, [])
    }

    func test_append_shouldAppendErrorToItems() {
        let expectedError = VASTParsingError.unexpectedStartOfElement(
            parentElementName: "VAST",
            unexpectedElementName: "AdaptationSet"
        )
        let errorLog = VAST.Parsing.ErrorLog()
        errorLog.append(expectedError)
        XCTAssertEqual(errorLog.items, [expectedError])
    }
}
