import VASTParser
import Foundation
import XCTest

private let exampleNoXMLEncodedAttribute = """
<AdParameters>key=value</AdParameters>
"""
private let exampleXMLEncodedAttributeFalse = """
<AdParameters xmlEncoded="false">key=value</AdParameters>
"""
private let exampleXMLEncodedAttributeTrue = """
<AdParameters xmlEncoded="true">
    <Key>value</Key>
</AdParameters>
"""
private let exampleDefaults = """
<AdParameters>
</AdParameters>
"""

class AdParametersParsingContextTests: XCTestCase {
    func test_parse_exampleNoXMLEncodedAttribute() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(exampleNoXMLEncodedAttribute),
            VAST.Element.AdParameters(content: "key=value", xmlEncoded: nil)
        )
    }

    func test_parse_exampleXMLEncodedAttributeFalse() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(exampleXMLEncodedAttributeFalse),
            VAST.Element.AdParameters(content: "key=value", xmlEncoded: false)
        )
    }

    func test_parse_exampleXMLEncodedAttributeTrue() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(exampleXMLEncodedAttributeTrue),
            VAST.Element.AdParameters(content: "<Key>value</Key>", xmlEncoded: true)
        )
    }

    func test_parse_exampleDefaults() throws {
        let expectedContentString = "DEFAULT_PARAM"
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(string: expectedContentString),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(exampleDefaults),
            VAST.Element.AdParameters(content: expectedContentString, xmlEncoded: nil)
        )
    }
}
