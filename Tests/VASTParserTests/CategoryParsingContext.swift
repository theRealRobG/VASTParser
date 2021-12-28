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

extension AnyParser: CategoryParsingContextDelegate {
    func categoryParsingContext(
        _ parsingContext: VAST.Parsing.CategoryParsingContext,
        didParse parsedContent: VAST.Element.Category
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}

class CategoryParsingContextTests: XCTestCase {
    func test_noAuthorityExample() throws {
        try XCTAssertEqual(
            AnyParser().parse(noAuthorityExample),
            VAST.Element.Category(authority: nil, content: "Example Category")
        )
    }

    func test_authorityExample() throws {
        try XCTAssertEqual(
            AnyParser().parse(authorityExample),
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
            AnyParser(behaviour: behaviour).parse(defaultsExample),
            VAST.Element.Category(authority: nil, content: expectedContent)
        )
    }

    func test_defaultsExample_whenStrictParsing_shouldNotParse() throws {
        let parser = AnyParser<VAST.Element.Category>(behaviour: VAST.Parsing.Behaviour(strictness: .strict))
        XCTAssertThrowsError(try parser.parse(defaultsExample)) { error in
            XCTAssertEqual(
                (error as NSError).userInfo[anyParserErrorLogUserInfoKey] as? [VASTParsingError],
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
