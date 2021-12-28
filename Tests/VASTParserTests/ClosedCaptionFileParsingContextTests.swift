import VASTParser
import Foundation
import XCTest

private let noAttributesExample = """
<ClosedCaptionFile>
    <![CDATA[https://mycdn.example.com/creatives/creative001.ttml]]>
</ClosedCaptionFile>
"""
private let noLanguageExample = """
<ClosedCaptionFile type="application/ttml+xml">
    <![CDATA[https://mycdn.example.com/creatives/creative001.ttml]]>
</ClosedCaptionFile>
"""
private let noTypeExample = """
<ClosedCaptionFile language="zh-CH">
    <![CDATA[https://mycdn.example.com/creatives/creative001.ttml]]>
</ClosedCaptionFile>
"""
private let typeAndLanguageExample = """
<ClosedCaptionFile type="text/srt" language="en">
    <![CDATA[https://mycdn.example.com/creatives/creative001.srt]]>
</ClosedCaptionFile>
"""
private let defaultsExample = """
<ClosedCaptionFile>
</ClosedCaptionFile>
"""

class ClosedCaptionFileParsingContextTests: XCTestCase {
    func test_noAttributesExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(noAttributesExample),
            VAST.Element.ClosedCaptionFile(
                content: URL(string: "https://mycdn.example.com/creatives/creative001.ttml")!,
                type: nil,
                language: nil
            )
        )
    }

    func test_noLanguageExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(noLanguageExample),
            VAST.Element.ClosedCaptionFile(
                content: URL(string: "https://mycdn.example.com/creatives/creative001.ttml")!,
                type: "application/ttml+xml",
                language: nil
            )
        )
    }

    func test_noTypeExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(noTypeExample),
            VAST.Element.ClosedCaptionFile(
                content: URL(string: "https://mycdn.example.com/creatives/creative001.ttml")!,
                type: nil,
                language: "zh-CH"
            )
        )
    }

    func test_typeAndLanguageExample() throws {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(typeAndLanguageExample),
            VAST.Element.ClosedCaptionFile(
                content: URL(string: "https://mycdn.example.com/creatives/creative001.srt")!,
                type: "text/srt",
                language: "en"
            )
        )
    }

    func test_defaultsExample() throws {
        let expectedContent = URL(string: "https://DEFAULT_URL")!
        let behaviour = VAST.Parsing.Behaviour(
            defaults: VAST.Parsing.DefaultConstants(url: expectedContent),
            strictness: .loose
        )
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser(behaviour: behaviour).parse(defaultsExample),
            VAST.Element.ClosedCaptionFile(content: expectedContent, type: nil, language: nil)
        )
    }

    func test_defaultsExample_whenStrictParsing_shouldNotParse() throws {
        let parser = VAST.Parsing.AnyElementParser<VAST.Element.ClickTracking>(
            behaviour: VAST.Parsing.Behaviour(strictness: .strict)
        )
        XCTAssertThrowsError(try parser.parse(defaultsExample)) { error in
            XCTAssertEqual(
                (error as NSError).userInfo[VAST.Parsing.anyElementParserErrorLogUserInfoKey] as? [VASTParsingError],
                [
                    VASTParsingError.missingRequiredProperty(
                        parentElementName: .vastElementName.closedCaptionFile,
                        missingPropertyName: "content"
                    )
                ]
            )
        }
    }
}

