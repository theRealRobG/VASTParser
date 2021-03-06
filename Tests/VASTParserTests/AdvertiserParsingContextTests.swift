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
private let advertiserDefaultWithWhitespaceExample = """
<Advertiser>
</Advertiser>
"""

class AdvertiserPasrsingContextTests: XCTestCase {
    func test_advertiserExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(advertiserExample),
            VAST.Element.Advertiser(
                id: nil,
                content: "Rob G Advertising Inc."
            )
        )
    }

    func test_advertiserWithIdExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(advertiserWithIdExample),
            VAST.Element.Advertiser(
                id: "1234abcd",
                content: "Super Advertising Plc."
            )
        )
    }

    func test_advertiserDefaultExample() {
        let expectedString = "TEST_ADVERTISER"
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(
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

    func test_advertiserDefaultWithWhitespaceExample() {
        let expectedString = "TEST_ADVERTISER"
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(string: expectedString),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(advertiserDefaultWithWhitespaceExample),
            VAST.Element.Advertiser(id: nil, content: expectedString)
        )
    }
}
