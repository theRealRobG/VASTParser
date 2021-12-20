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

extension AnyParser: AdParametersParsingContextDelegate {
    func adParametersParsingContext(
        _ parsingContext: VAST.Parsing.AdParametersParsingContext,
        didParse adParameters: VAST.Element.AdParameters
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = adParameters as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}

class AdParametersParsingContextTests: XCTestCase {
    func test_parse_exampleNoXMLEncodedAttribute() throws {
        let params = try AnyParser<VAST.Element.AdParameters>().parse(exampleNoXMLEncodedAttribute)
        XCTAssertEqual(params, VAST.Element.AdParameters(content: "key=value", xmlEncoded: nil))
    }

    func test_parse_exampleXMLEncodedAttributeFalse() throws {
        let params = try AnyParser<VAST.Element.AdParameters>().parse(exampleXMLEncodedAttributeFalse)
        XCTAssertEqual(params, VAST.Element.AdParameters(content: "key=value", xmlEncoded: false))
    }

    func test_parse_exampleXMLEncodedAttributeTrue() throws {
        let params = try AnyParser<VAST.Element.AdParameters>().parse(exampleXMLEncodedAttributeTrue)
        XCTAssertEqual(params, VAST.Element.AdParameters(content: "<Key>value</Key>", xmlEncoded: true))
    }
}
