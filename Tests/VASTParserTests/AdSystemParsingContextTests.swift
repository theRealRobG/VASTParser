import VASTParser
import Foundation
import XCTest

private let adSystemNoVersion = """
<AdSystem>theRealRobG</AdSystem>
"""
private let adSystemWithVersion = """
<AdSystem version="1.2.3">Amazing Ads</AdSystem>
"""

extension AnyParser: AdSystemParsingContextDelegate {
    func adSystemParsingContext(
        _ parsingContext: VAST.Parsing.AdSystemParsingContext,
        didParse adSystem: VAST.Element.AdSystem
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = adSystem as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}

class AdSystemParsingContextTests: XCTestCase {
    func test_parse_adSystemNoVersion() throws {
        let params = try AnyParser<VAST.Element.AdSystem>().parse(adSystemNoVersion)
        XCTAssertEqual(params, VAST.Element.AdSystem(content: "theRealRobG", version: nil))
    }

    func test_parse_adSystemWithVersion() throws {
        let params = try AnyParser<VAST.Element.AdSystem>().parse(adSystemWithVersion)
        XCTAssertEqual(params, VAST.Element.AdSystem(content: "Amazing Ads", version: "1.2.3"))
    }
}
