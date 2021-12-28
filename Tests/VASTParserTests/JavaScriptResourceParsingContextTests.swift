import VASTParser
import Foundation
import XCTest

private let resourceBrowserOptionalTrue = """
<JavaScriptResource apiFramework="omid" browserOptional="true">
    <![CDATA[https://verificationvendor.com/omid.js]]>
</JavaScriptResource>
"""
private let resourceBrowserOptionalFalse = """
<JavaScriptResource apiFramework="theRealRobG" browserOptional="false">
    <![CDATA[https://verificationvendor.com/theRealRobG.js]]>
</JavaScriptResource>
"""
private let resourceBrowserOptionalDefaultValues = """
<JavaScriptResource></JavaScriptResource>
"""

class JavaScriptResourceParsingContextTests: XCTestCase {
    func test_resourceBrowserOptionalTrue() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(resourceBrowserOptionalTrue),
            VAST.Element.JavaScriptResource(
                content: URL(string: "https://verificationvendor.com/omid.js")!,
                apiFramework: "omid",
                browserOptional: true
            )
        )
    }

    func test_resourceBrowserOptionalFalse() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(resourceBrowserOptionalFalse),
            VAST.Element.JavaScriptResource(
                content: URL(string: "https://verificationvendor.com/theRealRobG.js")!,
                apiFramework: "theRealRobG",
                browserOptional: false
            )
        )
    }

    func test_resourceBrowserOptionalDefaultValues() throws {
        let defaults = VAST.Parsing.DefaultConstants(
            string: "some_default_string",
            url: URL(string: "https://some.test.verification/test.js")!
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(
                behaviour: VAST.Parsing.Behaviour(
                    defaults: defaults,
                    strictness: .loose
                )
            ).parse(resourceBrowserOptionalDefaultValues),
            VAST.Element.JavaScriptResource(
                content: defaults.url,
                apiFramework: defaults.string,
                browserOptional: false
            )
        )
    }
}
