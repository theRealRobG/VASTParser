import VASTParser
import Foundation
import XCTest

private let adServingIdExample = """
<AdServingId>a532d16d-4d7f-4440-bd29-2ec0e693fc80</AdServingId>
"""
private let adTitleExample = """
<AdTitle>iabtechlab video ad</AdTitle>
"""
private let altTextExample = """
<AltText>The live click interaction</AltText>
"""
private let companionClickThroughExample = """
<CompanionClickThrough>http://www.tremormedia.com</CompanionClickThrough>
"""
private let descriptionExample = """
<Description>
    <![CDATA[This is sample. ]]>
</Description>
"""
private let durationExample = """
<Duration>00:00:16</Duration>
"""
private let errorExample = """
<Error>
    <![CDATA[http://adserver.com/noad.gif]]>
</Error>
"""
private let expiresExample = """
<Expires>60</Expires>
"""
private let htmlResourceExample = """
<HTMLResource>
    <![CDATA[<html><body>I'm a html snippet</body></html>]]>
</HTMLResource>
"""
private let iconClickThroughExample = """
<IconClickThrough>
    <![CDATA[http://www.example.icon.click.com]]>
</IconClickThrough>
"""
private let iconViewTrackingExample = """
<IconViewTracking>
    <![CDATA[http://www.example.icon.view.com]]>
</IconViewTracking>
"""
private let iFrameResourceExample = """
<IFrameResource>
    <![CDATA[https://www.example.iframe.com]]>
</IFrameResource>
"""
private let nonLinearClickThroughExample = """
<NonLinearClickThrough>
    <![CDATA[http://iabtechlab.com]]>
</NonLinearClickThrough>
"""
private let notViewableExample = """
<NotViewable>
    <![CDATA[https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1]]>
</NotViewable>
"""
private let vastAdTagURIExample = """
<VASTAdTagURI>
    <![CDATA[https://test.vast.ad.tag/tag.xml]]>
</VASTAdTagURI>
"""
private let verificationParametersExample = """
<VerificationParameters>
    <![CDATA[param=test]]>
</VerificationParameters>
"""
private let viewableExample = """
<Viewable>
    <![CDATA[https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1]]>
</Viewable>
"""
private let viewUndeterminedExample = """
<ViewUndetermined>
    <![CDATA[https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1]]>
</ViewUndetermined>
"""

class SimpleElementParsingTests: XCTestCase {
    func test_adServingIdExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(adServingIdExample),
            "a532d16d-4d7f-4440-bd29-2ec0e693fc80"
        )
    }

    func test_adTitleExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(adTitleExample),
            "iabtechlab video ad"
        )
    }

    func test_altTextExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(altTextExample),
            "The live click interaction"
        )
    }

    func test_companionClickThroughExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(companionClickThroughExample),
            URL(string: "http://www.tremormedia.com")!
        )
    }

    func test_descriptionExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(descriptionExample),
            "This is sample."
        )
    }

    func test_durationExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(durationExample),
            DurationString(seconds: 16)
        )
    }

    func test_errorExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(errorExample),
            URL(string: "http://adserver.com/noad.gif")!
        )
    }

    func test_expiresExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(expiresExample),
            60
        )
    }

    func test_htmlResourceExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(htmlResourceExample),
            "<html><body>I'm a html snippet</body></html>"
        )
    }

    func test_iconClickThroughExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(iconClickThroughExample),
            URL(string: "http://www.example.icon.click.com")!
        )
    }

    func test_iconViewTrackingExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(iconViewTrackingExample),
            URL(string: "http://www.example.icon.view.com")!
        )
    }

    func test_iFrameResourceExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(iFrameResourceExample),
            URL(string: "https://www.example.iframe.com")!
        )
    }

    func test_nonLinearClickThroughExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(nonLinearClickThroughExample),
            URL(string: "http://iabtechlab.com")!
        )
    }

    func test_notViewableExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(notViewableExample),
            URL(string: "https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1")!
        )
    }

    func test_vastAdTagURIExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(vastAdTagURIExample),
            URL(string: "https://test.vast.ad.tag/tag.xml")!
        )
    }

    func test_verificationParametersExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(verificationParametersExample),
            "param=test"
        )
    }

    func test_viewableExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(viewableExample),
            URL(string: "https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1")!
        )
    }

    func test_viewUndeterminedExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(viewUndeterminedExample),
            URL(string: "https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1")!
        )
    }
}
