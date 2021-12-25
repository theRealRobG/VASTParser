import VASTParser
import Foundation
import XCTest

private let advertiserExample = """
<Advertiser>Rob G Advertising Inc.</Advertiser>
"""
private let advertiserWithIdExample = """
<Advertiser id="1234abcd">Super Advertising Plc.</Advertiser>
"""
private let advertiserDefaultExample = """
<Advertiser/>
"""

extension AnyParser: AdvertiserParsingContextDelegate {
    func advertiserParsingContext(
        _ parsingContext: VAST.Parsing.AdvertiserParsingContext,
        parsedContent: VAST.Element.Advertiser
    ) {
        guard parsingContext === currentParsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}

class AdvertiserPasrsingContextTests: XCTestCase {
    func test_advertiserExample() {
        try XCTAssertEqual(
            AnyParser().parse(advertiserExample),
            VAST.Element.Advertiser(
                id: nil,
                content: "Rob G Advertising Inc."
            )
        )
    }

    func test_advertiserWithIdExample() {
        try XCTAssertEqual(
            AnyParser().parse(advertiserWithIdExample),
            VAST.Element.Advertiser(
                id: "1234abcd",
                content: "Super Advertising Plc."
            )
        )
    }

    func test_advertiserDefaultExample() {
        let expectedString = "TEST_ADVERTISER"
        try XCTAssertEqual(
            AnyParser(
                behaviour: VAST.Parsing.Behaviour(
                    defaults: VAST.Parsing.DefaultConstants(string: expectedString),
                    strictness: .loose
                )
            ).parse(advertiserDefaultExample),
            VAST.Element.Advertiser(
                id: nil,
                content: expectedString
            )
        )
    }
}
