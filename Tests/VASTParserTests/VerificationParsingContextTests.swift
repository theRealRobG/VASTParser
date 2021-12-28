import VASTParser
import Foundation
import XCTest

private let verificationExample = """
<Verification vendor="expectedVendor">
    <JavaScriptResource apiFramework="omid" browserOptional="true">
        <![CDATA[expectedJSResourceUrl]]>
    </JavaScriptResource>
    <TrackingEvents/>
    <VerificationParameters>
        <![CDATA[{"expectedKey":"663501"}]]>
    </VerificationParameters>
</Verification>
"""

private let verificationDefaultExample = """
<Verification></Verification>
"""

class VerificationParsingContextTests: XCTestCase {
    func test_verifciationExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(verificationExample),
            VAST.Element.Verification(
                vendor: "expectedVendor",
                javaScriptResource: [
                    VAST.Element.JavaScriptResource(
                        content: URL(string: "expectedJSResourceUrl")!,
                        apiFramework: "omid",
                        browserOptional: true
                    )
                ],
                executableResource: [],
                trackingEvents: [],
                verificationParameters: "{\"expectedKey\":\"663501\"}"
            )
        )
    }

    func test_verificationDefaultExample() {
        let defaultString = "TEST_STRING"
        let defaultURL = URL(string: "https://test.com/test?fake=true")!
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(
                behaviour: VAST.Parsing.Behaviour(
                    defaults: VAST.Parsing.DefaultConstants(
                        string: defaultString,
                        url: defaultURL
                    ),
                    strictness: .loose
                )
            ).parse(verificationDefaultExample),
            VAST.Element.Verification(
                vendor: defaultString,
                javaScriptResource: [],
                executableResource: [],
                trackingEvents: [],
                verificationParameters: nil
            )
        )
    }
}
