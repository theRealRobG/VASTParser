import VASTParser
import Foundation
import XCTest

private let adSystemNoVersion = """
<AdSystem>theRealRobG</AdSystem>
"""
private let adSystemWithVersion = """
<AdSystem version="1.2.3">Amazing Ads</AdSystem>
"""
private let adSystemDefaults = """
<AdSystem>
</AdSystem>
"""

class AdSystemParsingContextTests: XCTestCase {
    func test_parse_adSystemNoVersion() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(adSystemNoVersion),
            VAST.Element.AdSystem(content: "theRealRobG", version: nil)
        )
    }

    func test_parse_adSystemWithVersion() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(adSystemWithVersion),
            VAST.Element.AdSystem(content: "Amazing Ads", version: "1.2.3")
        )
    }

    func test_parse_adSystemDefaults() throws {
        let expectedContent = "DEFAULT_SYSTEM"
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(string: expectedContent),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(adSystemDefaults),
            VAST.Element.AdSystem(content: expectedContent, version: nil)
        )
    }
}
