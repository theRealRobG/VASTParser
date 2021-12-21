import VASTParser
import Foundation
import XCTest

private let resourceTypeSwift = """
<ExecutableResource apiFramework="XCTest" type="Swift">
    <![CDATA[XCTAssertTrue(true)]]>
</ExecutableResource>
"""
private let resourceTypeJS = """
<ExecutableResource apiFramework="random" type="JS">
    <![CDATA[
        const x = Math.random();
        assert(x > 0.5);
    ]]>
</ExecutableResource>
"""
private let resourceDefaultValues = """
<ExecutableResource></ExecutableResource>
"""

extension AnyParser: ExecutableResourceParsingContextDelegate {
    func executableResourceParsingContext(
        _ parsingContext: VAST.Parsing.ExecutableResourceParsingContext,
        didParse parsedContent: VAST.Element.ExecutableResource
    ) {
        guard parsingContext === currentParsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}

class ExecutableResourceParsingContextTests: XCTestCase {
    func test_resourceTypeSwift() throws {
        try XCTAssertEqual(
            AnyParser().parse(resourceTypeSwift),
            VAST.Element.ExecutableResource(
                content: "XCTAssertTrue(true)",
                apiFramework: "XCTest",
                type: "Swift"
            )
        )
    }

    func test_resourceTypeJS() throws {
        let resource = try AnyParser<VAST.Element.ExecutableResource>().parse(resourceTypeJS)
        XCTAssertEqual(resource.apiFramework, "random")
        XCTAssertEqual(resource.type, "JS")
        let lines = resource.content
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        XCTAssertEqual(lines.count, 2)
        XCTAssertEqual(lines.first, "const x = Math.random();")
        XCTAssertEqual(lines.last, "assert(x > 0.5);")
    }

    func test_resourceDefaultValues() throws {
        let defaults = VAST.Parsing.DefaultConstants(string: "some_default_string")
        try XCTAssertEqual(
            AnyParser(
                behaviour: VAST.Parsing.Behaviour(
                    defaults: defaults,
                    strictness: .loose
                )
            ).parse(resourceDefaultValues),
            VAST.Element.ExecutableResource(
                content: defaults.string,
                apiFramework: defaults.string,
                type: defaults.string
            )
        )
    }
}
