import VASTParser
import Foundation
import XCTest

private let trackingEventsExample = """
<TrackingEvents>
    <Tracking event="verificationNotExecuted">https://example.com/verification?swift=true</Tracking>
    <Tracking event="verificationNotExecuted">https://other.vendor.com/verification</Tracking>
</TrackingEvents>
"""

private let trackingEventsUnknownEventExample = """
<TrackingEvents>
    <Tracking event="customEvent">https://example.com/verification?swift=true</Tracking>
    <Tracking event="anotherCustomEvent">https://other.vendor.com/verification</Tracking>
</TrackingEvents>
"""

private let trackingEventsDefaultValuesExample = """
<TrackingEvents>
    <Tracking></Tracking>
    <Tracking></Tracking>
</TrackingEvents>
"""

private let trackingEventsDefaultValuesWithWhitespaceExample = """
<TrackingEvents>
    <Tracking>

    </Tracking>
    <Tracking>
    </Tracking>
</TrackingEvents>
"""

class VerificationTrackingEventsParsingContextTests: XCTestCase {
    func test_trackingEventsExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(trackingEventsExample),
            [
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://example.com/verification?swift=true")!,
                    event: .verificationNotExecuted
                ),
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://other.vendor.com/verification")!,
                    event: .verificationNotExecuted
                )
            ]
        )
    }

    func test_trackingEventsUnknownEventExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(trackingEventsUnknownEventExample),
            [
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://example.com/verification?swift=true")!,
                    event: .unknown("customEvent")
                ),
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://other.vendor.com/verification")!,
                    event: .unknown("anotherCustomEvent")
                )
            ]
        )
    }

    func test_trackingEventsDefaultValuesExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(
                behaviour: VAST.Parsing.Behaviour(
                    defaults: VAST.Parsing.DefaultConstants(
                        string: "TEST_STRING",
                        url: URL(string: "https://test.com/test")!
                    ),
                    strictness: .loose
                )
            ).parse(trackingEventsDefaultValuesExample),
            [
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://test.com/test")!,
                    event: .unknown("TEST_STRING")
                ),
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://test.com/test")!,
                    event: .unknown("TEST_STRING")
                )
            ]
        )
    }

    func test_trackingEventsDefaultValuesWithWhitespaceExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(
                behaviour: VAST.Parsing.Behaviour(
                    defaults: VAST.Parsing.DefaultConstants(
                        string: "TEST_STRING",
                        url: URL(string: "https://test.com/test")!
                    ),
                    strictness: .loose
                )
            ).parse(trackingEventsDefaultValuesWithWhitespaceExample),
            [
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://test.com/test")!,
                    event: .unknown("TEST_STRING")
                ),
                VAST.Element.Verification.Tracking(
                    url: URL(string: "https://test.com/test")!,
                    event: .unknown("TEST_STRING")
                )
            ]
        )
    }
}
