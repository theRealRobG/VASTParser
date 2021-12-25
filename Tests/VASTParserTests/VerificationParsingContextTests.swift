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

extension AnyParser: VerificationParsingContextDelegate {
    func verificationParsingContext(
        _ parsingContext: VAST.Parsing.VerificationParsingContext,
        didParse parsedContent: VAST.Element.Verification
    ) {
        guard parsingContext === currentParsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}

class VerificationParsingContextTests: XCTestCase {
    func test_verifciationExample() {
        try XCTAssertEqual(
            AnyParser().parse(verificationExample),
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
                verificiationParameters: "{\"expectedKey\":\"663501\"}"
            )
        )
    }

    func test_verificationDefaultExample() {
        let defaultString = "TEST_STRING"
        let defaultURL = URL(string: "https://test.com/test?fake=true")!
        try XCTAssertEqual(
            AnyParser(
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
                verificiationParameters: nil
            )
        )
    }
}
