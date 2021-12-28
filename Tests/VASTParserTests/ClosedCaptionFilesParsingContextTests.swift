import VASTParser
import Foundation
import XCTest

private let example = """
<ClosedCaptionFiles>
    <ClosedCaptionFile type="text/srt"  language="en">
        <![CDATA[https://mycdn.example.com/creatives/creative001.srt]]>
    </ClosedCaptionFile>
    <ClosedCaptionFile type="text/srt" language="fr">
        <![CDATA[https://mycdn.example.com/creatives/creative001-1.srt]]>
    </ClosedCaptionFile>
    <ClosedCaptionFile type="text/vtt"   language="zh-TW">
        <![CDATA[https://mycdn.example.com/creatives/creative001.vtt]]>
    </ClosedCaptionFile>
    <ClosedCaptionFile type="application/ttml+xml"  language="zh-CH">
        <![CDATA[https://mycdn.example.com/creatives/creative001.ttml]]>
    </ClosedCaptionFile>
</ClosedCaptionFiles>
"""

class ClosedCaptionFilesParsingContextTests: XCTestCase {
    func test_example() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser().parse(example),
            [
                VAST.Element.ClosedCaptionFile(
                    content: URL(string: "https://mycdn.example.com/creatives/creative001.srt")!,
                    type: "text/srt",
                    language: "en"
                ),
                VAST.Element.ClosedCaptionFile(
                    content: URL(string: "https://mycdn.example.com/creatives/creative001-1.srt")!,
                    type: "text/srt",
                    language: "fr"
                ),
                VAST.Element.ClosedCaptionFile(
                    content: URL(string: "https://mycdn.example.com/creatives/creative001.vtt")!,
                    type: "text/vtt",
                    language: "zh-TW"
                ),
                VAST.Element.ClosedCaptionFile(
                    content: URL(string: "https://mycdn.example.com/creatives/creative001.ttml")!,
                    type: "application/ttml+xml",
                    language: "zh-CH"
                )
            ]
        )
    }
}
