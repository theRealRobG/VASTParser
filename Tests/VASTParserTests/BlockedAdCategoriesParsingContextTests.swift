import VASTParser
import Foundation
import XCTest

private let noAuthorityExample = """
<BlockedAdCategories>
    Example
</BlockedAdCategories>
"""
private let authorityExample = """
<BlockedAdCategories authority="iabtechlab.com">232</BlockedAdCategories>
"""
private let defaultsExample = """
<BlockedAdCategories>
</BlockedAdCategories>
"""

class BlockedAdCategoriesParsingContextTests: XCTestCase {
    func test_noAuthorityExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(noAuthorityExample),
            VAST.Element.BlockedAdCategories(content: "Example", authority: nil)
        )
    }

    func test_authorityExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(authorityExample),
            VAST.Element.BlockedAdCategories(content: "232", authority: URL(string: "iabtechlab.com")!)
        )
    }

    func test_defaultsExample() throws {
        let expectedDefaultContent = "EXAMPLE_AD_CATEGORY"
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(string: expectedDefaultContent),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(defaultsExample),
            VAST.Element.BlockedAdCategories(content: expectedDefaultContent, authority: nil)
        )
    }
}
