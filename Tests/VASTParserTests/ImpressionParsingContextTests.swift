import VASTParser
import Foundation
import XCTest

private let withIdExample = """
<Impression id="Impression-ID"><![CDATA[https://example.com/track/impression]]></Impression>
"""
private let withoutIdExample = """
<Impression>
<![CDATA[
http://example.com/track/impression
]]>
</Impression>
"""
private let blankExample = """
<Impression>about:blank</Impression>
"""
private let defaultsExample = """
<Impression>
</Impression>
"""

class ImpressionParsingContextTests: XCTestCase {
    func test_withIdExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(withIdExample),
            VAST.Element.Impression(
                id: "Impression-ID",
                content: .url(URL(string: "https://example.com/track/impression")!)
            )
        )
    }
    func test_withoutIdExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(withoutIdExample),
            VAST.Element.Impression(
                id: nil,
                content: .url(URL(string: "http://example.com/track/impression")!)
            )
        )
    }
    func test_blankExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(blankExample),
            VAST.Element.Impression(
                id: nil,
                content: .blank
            )
        )
    }
    func test_defaultsExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(defaultsExample),
            VAST.Element.Impression(
                id: nil,
                content: .blank
            )
        )
    }
}
