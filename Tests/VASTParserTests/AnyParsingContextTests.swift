import VASTParser
import XCTest

private class TestParsingContext: VAST.Parsing.AnyParsingContext {
    var parserDidStartElementListener: ((XMLParser, String, [String: String]) -> Void)?
    var didCompleteParsingListener: (((String) throws -> Void, (String) throws -> Void) throws -> Void)?
    
    override func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        attributes attributeDict: [String: String]
    ) {
        parserDidStartElementListener?(parser, elementName, attributeDict)
    }

    override func didCompleteParsing(
        missingConstant: (String) throws -> Void,
        missingElement: (String) throws -> Void
    ) throws {
        try didCompleteParsingListener?(missingConstant, missingElement)
    }
}

private class MockXMLParserDelegate: NSObject, XMLParserDelegate {}

class AnyParsingContextTests: XCTestCase {
    var xmlParser: XMLParser!
    var errorLog: VAST.Parsing.ErrorLog!
    var behaviour: VAST.Parsing.Behaviour!
    private var mockParserDelegate: MockXMLParserDelegate!

    override func setUp() {
        xmlParser = XMLParser()
        errorLog = VAST.Parsing.ErrorLog()
        behaviour = VAST.Parsing.Behaviour()
        mockParserDelegate = MockXMLParserDelegate()
    }

    func test_init_shouldSetDelegate() {
        let context = makeTestParsingContext()
        XCTAssert(xmlParser.delegate === context)
    }

    func test_parserDidStartElement_whenExpectedElement_shouldStartElement() {
        let startElementExp = expectation(description: "wait for start element")
        let expectedElementName = "InLine"
        let context = makeTestParsingContext(
            expectedElementNames: [expectedElementName],
            behaviour: VAST.Parsing.Behaviour(strictness: .strict)
        )
        context.parserDidStartElementListener = { parser, elementName, attributes in
            XCTAssert(parser === self.xmlParser)
            XCTAssert(elementName == expectedElementName)
            XCTAssert(attributes == [:])
            startElementExp.fulfill()
        }
        context.parser(
            xmlParser,
            didStartElement: expectedElementName,
            namespaceURI: nil,
            qualifiedName: nil,
            attributes: [:]
        )
        wait(forExpectation: startElementExp)
    }

    func test_parserDidStartElement_whenUnexpectedElement_shouldAppendToErrorLog() {
        let context = makeTestParsingContext()
        context.parser(
            xmlParser,
            didStartElement: "InLine",
            namespaceURI: nil,
            qualifiedName: nil,
            attributes: [:]
        )
        XCTAssertEqual(
            errorLog.items,
            [
                .unexpectedStartOfElement(
                    parentElementName: "VAST",
                    unexpectedElementName: "InLine"
                )
            ]
        )
    }

    func test_parserDidStartElement_whenUnexpectedElement_shouldNotCompleteUntilUnexpectedElementComplete() {
        let startElementExp = expectation(description: "wait for start element")
        let expectedElementName = "InLine"
        startElementExp.expectedFulfillmentCount = 1
        let context = makeTestParsingContext(expectedElementNames: [expectedElementName])
        context.parserDidStartElementListener = { _, elementName, _ in
            XCTAssert(elementName == expectedElementName)
            startElementExp.fulfill()
        }
        /*
         <Unexpected>
           <InLine></InLine>
           <MoreUnexpected></MoreUnexpected>
         </Unexpected>
         <InLine>
         */
        context.parser(
            xmlParser,
            didStartElement: "Unexpected",
            namespaceURI: nil,
            qualifiedName: nil,
            attributes: [:]
        )
        context.parser(
            xmlParser,
            didStartElement: expectedElementName,
            namespaceURI: nil,
            qualifiedName: nil,
            attributes: [:]
        )
        context.parser(
            xmlParser,
            didEndElement: expectedElementName,
            namespaceURI: nil,
            qualifiedName: nil
        )
        context.parser(
            xmlParser,
            didStartElement: "MoreUnexpected",
            namespaceURI: nil,
            qualifiedName: nil,
            attributes: [:]
        )
        context.parser(
            xmlParser,
            didEndElement: "MoreUnexpected",
            namespaceURI: nil,
            qualifiedName: nil
        )
        context.parser(
            xmlParser,
            didEndElement: "Unexpected",
            namespaceURI: nil,
            qualifiedName: nil
        )
        context.parser(
            xmlParser,
            didStartElement: expectedElementName,
            namespaceURI: nil,
            qualifiedName: nil,
            attributes: [:]
        )
        wait(forExpectation: startElementExp)
    }

    func test_parserDidStartElement_whenAllowAllElementNames_shouldCompleteWithNoErrors() {
        let startElementExp = expectation(description: "wait for start element")
        startElementExp.expectedFulfillmentCount = 2
        let expectedElementNames = ["UnexpectedOne", "UnexpectedTwo"]
        let expectedAttributeDicts = [["UnexpectedKey": "UnexpectedValue"], [:]]
        let context = makeTestParsingContext(expectedElementNames: .all)
        var callIndex = 0
        context.parserDidStartElementListener = { _, elementName, attributeDict in
            XCTAssertEqual(elementName, expectedElementNames[callIndex])
            XCTAssertEqual(attributeDict, expectedAttributeDicts[callIndex])
            callIndex += 1
            startElementExp.fulfill()
        }
        for i in 0...1 {
            context.parser(
                xmlParser,
                didStartElement: expectedElementNames[i],
                namespaceURI: nil,
                qualifiedName: nil,
                attributes: expectedAttributeDicts[i]
            )
        }
        wait(forExpectation: startElementExp)
    }

    func test_parserDidEndElement_whenExpectedElement_shouldCompleteParsingAndUnlink() {
        let completeParsingExpectation = expectation(description: "wait for complete parsing")
        let expectedElementName = "AdSystem"
        let context = makeTestParsingContext(elementName: expectedElementName)
        context.didCompleteParsingListener = { _, _ in
            completeParsingExpectation.fulfill()
        }
        XCTAssert(xmlParser.delegate === context)
        XCTAssertNotNil(context.delegate)
        XCTAssertNotNil(context.parentContext)
        context.parser(
            xmlParser,
            didEndElement: expectedElementName,
            namespaceURI: nil,
            qualifiedName: nil
        )
        AssertUnlinked(context: context)
        wait(forExpectation: completeParsingExpectation)
    }

    func test_parserDidEndElement_whenUnexpectedElement_shouldAppendToErrorLog() {
        let context = makeTestParsingContext()
        XCTAssertEqual(errorLog.items, [])
        context.parser(
            xmlParser,
            didEndElement: "Unexpected",
            namespaceURI: nil,
            qualifiedName: nil
        )
        XCTAssertEqual(
            errorLog.items, [
                .unexpectedEndOfElement(
                    parentElementName: "VAST",
                    unexpectedElementName: "Unexpected"
                )
            ]
        )
    }

    func test_parserDidEndElement_whenMissingConstant_shouldAppendToErrorLog() {
        let errorLogExp = expectation(description: "wait for append to error log")
        let expectedMissingConstant = "id"
        let context = makeTestParsingContext(behaviour: VAST.Parsing.Behaviour(strictness: .loose))
        context.didCompleteParsingListener = { missingConstant, _ in
            XCTAssertNoThrow(try missingConstant(expectedMissingConstant))
            errorLogExp.fulfill()
        }
        context.parser(xmlParser, didEndElement: "VAST", namespaceURI: nil, qualifiedName: nil)
        wait(forExpectation: errorLogExp)
        XCTAssertEqual(
            errorLog.items,
            [
                .missingRequiredProperty(
                    parentElementName: "VAST",
                    missingPropertyName: expectedMissingConstant
                )
            ]
        )
    }

    func test_parserDidEndElement_whenMissingConstantAndStrictParsing_shouldThrow() {
        let errorLogExp = expectation(description: "wait for append to error log")
        let expectedMissingConstant = "id"
        let context = makeTestParsingContext(behaviour: VAST.Parsing.Behaviour(strictness: .strict))
        context.didCompleteParsingListener = { missingConstant, _ in
            XCTAssertThrowsError(try missingConstant(expectedMissingConstant))
            errorLogExp.fulfill()
        }
        context.parser(xmlParser, didEndElement: "VAST", namespaceURI: nil, qualifiedName: nil)
        wait(forExpectation: errorLogExp)
        XCTAssertEqual(
            errorLog.items,
            [
                .missingRequiredProperty(
                    parentElementName: "VAST",
                    missingPropertyName: expectedMissingConstant
                )
            ]
        )
    }

    func test_parserDidEndElement_whenMissingElement_shouldAppendToErrorLog() {
        let errorLogExp = expectation(description: "wait for append to error log")
        let expectedMissingElement = "AdSystem"
        let context = makeTestParsingContext(behaviour: VAST.Parsing.Behaviour(strictness: .loose))
        context.didCompleteParsingListener = { _, missingElement in
            XCTAssertNoThrow(try missingElement(expectedMissingElement))
            errorLogExp.fulfill()
        }
        context.parser(xmlParser, didEndElement: "VAST", namespaceURI: nil, qualifiedName: nil)
        wait(forExpectation: errorLogExp)
        XCTAssertEqual(
            errorLog.items,
            [
                .missingRequiredProperty(
                    parentElementName: "VAST",
                    missingPropertyName: expectedMissingElement
                )
            ]
        )
    }

    func test_parserDidEndElement_whenMissingElementAndStrictParsing_shouldThrow() {
        let errorLogExp = expectation(description: "wait for append to error log")
        let expectedMissingElement = "AdSystem"
        let context = makeTestParsingContext(behaviour: VAST.Parsing.Behaviour(strictness: .strict))
        context.didCompleteParsingListener = { _, missingElement in
            XCTAssertThrowsError(try missingElement(expectedMissingElement))
            errorLogExp.fulfill()
        }
        context.parser(xmlParser, didEndElement: "VAST", namespaceURI: nil, qualifiedName: nil)
        wait(forExpectation: errorLogExp)
        XCTAssertEqual(
            errorLog.items,
            [
                .missingRequiredProperty(
                    parentElementName: "VAST",
                    missingPropertyName: expectedMissingElement
                )
            ]
        )
    }

    func test_parserDidEndElement_whenWasUnexpectedStartElementAndStrictParsing_shouldUnlinkWithoutComplete() {
        let completeExp = expectation(description: "wait for complete")
        completeExp.isInverted = true
        let context = makeTestParsingContext(behaviour: VAST.Parsing.Behaviour(strictness: .strict))
        context.didCompleteParsingListener = { _, _ in
            completeExp.fulfill()
        }
        /*
         <VAST>
           <Unexpected></Unexpected>
         </VAST>
         */
        context.parser(
            xmlParser,
            didStartElement: "Unexpected",
            namespaceURI: nil,
            qualifiedName: nil,
            attributes: [:]
        )
        context.parser(
            xmlParser,
            didEndElement: "Unexpected",
            namespaceURI: nil,
            qualifiedName: nil
        )
        context.parser(
            xmlParser,
            didEndElement: "VAST",
            namespaceURI: nil,
            qualifiedName: nil
        )
        AssertUnlinked(context: context)
        XCTAssertEqual(
            errorLog.items,
            [
                .unexpectedStartOfElement(
                    parentElementName: "VAST",
                    unexpectedElementName: "Unexpected"
                )
            ]
        )
        wait(forExpectation: completeExp)
    }

    func test_parserDidEndElement_whenWasUnexpectedEndElementAndStrictParsing_shouldUnlinkWithoutComplete() {
        let completeExp = expectation(description: "wait for complete")
        completeExp.isInverted = true
        let context = makeTestParsingContext(behaviour: VAST.Parsing.Behaviour(strictness: .strict))
        context.didCompleteParsingListener = { _, _ in
            completeExp.fulfill()
        }
        /*
         <VAST>
           </Unexpected>
         </VAST>
         */
        context.parser(
            xmlParser,
            didEndElement: "Unexpected",
            namespaceURI: nil,
            qualifiedName: nil
        )
        context.parser(
            xmlParser,
            didEndElement: "VAST",
            namespaceURI: nil,
            qualifiedName: nil
        )
        AssertUnlinked(context: context)
        XCTAssertEqual(
            errorLog.items,
            [
                .unexpectedEndOfElement(
                    parentElementName: "VAST",
                    unexpectedElementName: "Unexpected"
                )
            ]
        )
        wait(forExpectation: completeExp)
    }
}

private extension AnyParsingContextTests {
    func makeTestParsingContext(
        elementName: String = "VAST",
        attributes: [String: String] = [:],
        expectedElementNames: Set<String> = [],
        behaviour: VAST.Parsing.Behaviour = VAST.Parsing.Behaviour()
    ) -> TestParsingContext {
        TestParsingContext(
            xmlParser: xmlParser,
            elementName: elementName,
            attributes: attributes,
            expectedElementNames: .some(expectedElementNames),
            errorLog: errorLog,
            behaviour: behaviour,
            delegate: self,
            parentContext: mockParserDelegate
        )
    }

    func makeTestParsingContext(
        elementName: String = "VAST",
        attributes: [String: String] = [:],
        expectedElementNames: VAST.Parsing.AnyParsingContext.ExpectedElementNames,
        behaviour: VAST.Parsing.Behaviour = VAST.Parsing.Behaviour()
    ) -> TestParsingContext {
        TestParsingContext(
            xmlParser: xmlParser,
            elementName: elementName,
            attributes: attributes,
            expectedElementNames: expectedElementNames,
            errorLog: errorLog,
            behaviour: behaviour,
            delegate: self,
            parentContext: mockParserDelegate
        )
    }

    func AssertUnlinked(context: TestParsingContext, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssert(xmlParser.delegate is MockXMLParserDelegate)
        XCTAssertNil(context.delegate)
        XCTAssertNil(context.parentContext)
    }
}
