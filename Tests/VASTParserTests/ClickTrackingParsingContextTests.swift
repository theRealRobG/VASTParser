import VASTParser
import Foundation
import XCTest

private let clickTrackingNoIdExample = """
<ClickTracking>http://example.com/trackingurl/click</ClickTracking>
"""
private let clickTrackingWithIdExample = """
<ClickTracking id="blog">
    <![CDATA[https://iabtechlab.com]]>
</ClickTracking>
"""
private let clickTrackingDefaultsExample = """
<ClickTracking>
</ClickTracking>
"""

class ClickTrackingParsingContextTests: XCTestCase {
    func test_clickTrackingNoIdExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(clickTrackingNoIdExample),
            VAST.Element.ClickTracking(
                content: URL(string: "http://example.com/trackingurl/click")!,
                id: nil
            )
        )
    }

    func test_clickTrackingWithIdExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(clickTrackingWithIdExample),
            VAST.Element.ClickTracking(
                content: URL(string: "https://iabtechlab.com")!,
                id: "blog"
            )
        )
    }

    func test_clickTrackingDefaultsExample() throws {
        let expectedContent = URL(string: "https://DEFAULT_URL")!
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(url: expectedContent),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(clickTrackingDefaultsExample),
            VAST.Element.ClickTracking(content: expectedContent, id: nil)
        )
    }

    func test_clickTrackingDefaultsExample_whenStrictParsing_shouldNotParse() throws {
        let parser = VAST.Parsing.AnyElementParser<VAST.Element.ClickTracking>(
            behaviour: VAST.Parsing.Behaviour(strictness: .strict)
        )
        XCTAssertThrowsError(try parser.parse(clickTrackingDefaultsExample)) { error in
            XCTAssertEqual(
                (error as NSError).userInfo[VAST.Parsing.anyElementParserErrorLogUserInfoKey] as? [VASTParsingError],
                [
                    VASTParsingError.missingRequiredProperty(
                        parentElementName: .vastElementName.clickTracking,
                        missingPropertyName: "content"
                    )
                ]
            )
        }
    }
}
