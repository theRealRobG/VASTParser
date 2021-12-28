import VASTParser
import Foundation
import XCTest

private let noIdExample = """
<ClickThrough><![CDATA[https://test.ad.server.com/ads/click?source=test]]></ClickThrough>
"""
private let idExample = """
<ClickThrough id="GDFP">
    <![CDATA[https://pubads.g.doubleclick.net/pcs/click?test=ABCD]]>
</ClickThrough>
"""
private let defaultsExample = """
<ClickThrough>
</ClickThrough>
"""

class ClickThroughParsingContextTests: XCTestCase {
    func test_noIdExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(noIdExample),
            VAST.Element.ClickThrough(
                content: URL(string: "https://test.ad.server.com/ads/click?source=test")!,
                id: nil
            )
        )
    }

    func test_idExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(idExample),
            VAST.Element.ClickThrough(
                content: URL(string: "https://pubads.g.doubleclick.net/pcs/click?test=ABCD")!,
                id: "GDFP"
            )
        )
    }

    func test_defaultsExample() throws {
        let expectedContent = URL(string: "https://DEFAULT_URL")!
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(url: expectedContent),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(defaultsExample),
            VAST.Element.ClickThrough(content: expectedContent, id: nil)
        )
    }

    func test_defaultsExample_whenStrictParsing_shouldNotParse() throws {
        let parser = VAST.Parsing.AnyElementParser<VAST.Element.ClickThrough>(
            behaviour: VAST.Parsing.Behaviour(strictness: .strict)
        )
        XCTAssertThrowsError(try parser.parse(defaultsExample)) { error in
            XCTAssertEqual(
                (error as NSError).userInfo[VAST.Parsing.anyElementParserErrorLogUserInfoKey] as? [VASTParsingError],
                [
                    VASTParsingError.missingRequiredProperty(
                        parentElementName: .vastElementName.clickThrough,
                        missingPropertyName: "content"
                    )
                ]
            )
        }
    }
}
