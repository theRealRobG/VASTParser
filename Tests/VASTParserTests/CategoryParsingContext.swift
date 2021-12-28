import VASTParser
import Foundation
import XCTest

private let noAuthorityExample = """
<Category>
    Example Category
</Category>
"""
private let authorityExample = """
<Category authority="iabtechlab.com">232</Category>
"""
private let defaultsExample = """
<Category>
</Category>
"""

class CategoryParsingContextTests: XCTestCase {
    func test_noAuthorityExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(noAuthorityExample),
            VAST.Element.Category(authority: nil, content: "Example Category")
        )
    }

    func test_authorityExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(authorityExample),
            VAST.Element.Category(authority: URL(string: "iabtechlab.com")!, content: "232")
        )
    }

    func test_defaultsExample() throws {
        let expectedContent = "DEFAULT_CATEGORY"
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(string: expectedContent),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(defaultsExample),
            VAST.Element.Category(authority: nil, content: expectedContent)
        )
    }

    func test_defaultsExample_whenStrictParsing_shouldNotParse() throws {
        let parser = VAST.Parsing.AnyElementParser<VAST.Element.Category>(
            behaviour: VAST.Parsing.Behaviour(strictness: .strict)
        )
        XCTAssertThrowsError(try parser.parse(defaultsExample)) { error in
            XCTAssertEqual(
                (error as NSError).userInfo[VAST.Parsing.anyElementParserErrorLogUserInfoKey] as? [VASTParsingError],
                [
                    VASTParsingError.missingRequiredProperty(
                        parentElementName: .vastElementName.category,
                        missingPropertyName: "content"
                    )
                ]
            )
        }
    }
}
