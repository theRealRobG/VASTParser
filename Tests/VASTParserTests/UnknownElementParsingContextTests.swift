import Foundation
import VASTParser
import XCTest

private class MockUnknownElementParsingContextDelegate: UnknownElementParsingContextDelegate {
    var didParseListener: ((VAST.Parsing.UnknownElementParsingContext, VAST.Parsing.UnknownElement) -> Void)?

    func unknownElementParsingContext(
        _ parsingContext: VAST.Parsing.UnknownElementParsingContext,
        didParse parsedContent: VAST.Parsing.UnknownElement
    ) {
        didParseListener?(parsingContext, parsedContent)
    }
}

class UnknownElementParsingContextTests: XCTestCase {
    var sut: VAST.Parsing.UnknownElementParsingContext!
    var xmlParser: XMLParser!
    var elementName: String!
    var errorLog: VAST.Parsing.ErrorLog!
    let defaultString = "TEST_STRING"
    var behaviour: VAST.Parsing.Behaviour!
    private var mockDelegate: MockUnknownElementParsingContextDelegate!

    override func setUp() {
        xmlParser = XMLParser()
        elementName = "SomeElement"
        errorLog = VAST.Parsing.ErrorLog()
        behaviour = VAST.Parsing.Behaviour(defaults: VAST.Parsing.DefaultConstants(string: defaultString))
        mockDelegate = MockUnknownElementParsingContextDelegate()
        sut = VAST.Parsing.UnknownElementParsingContext(
            xmlParser: xmlParser,
            elementName: elementName,
            attributes: [:],
            errorLog: errorLog,
            behaviour: behaviour,
            delegate: mockDelegate,
            parentContext: nil
        )
    }

    func test_didCompleteParsing_withNothingFound_shouldStillNotifyDelegateWithMinimalElement() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        mockDelegate.didParseListener = { context, element in
            XCTAssert(context === self.sut)
            XCTAssertEqual(element.name, self.elementName)
            XCTAssert(element.content.isEmpty)
            XCTAssertEqual(element.attributes, [:])
            delegateExp.fulfill()
        }
        try sut.didCompleteParsing(missingConstant: { _ in }, missingElement: { _ in })
        wait(forExpectation: delegateExp)
    }

    func test_didCompleteParsing_whenCharactersFound_shouldAppendToElementContent() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        let expectedString = "Test string"
        mockDelegate.didParseListener = { _, element in
            switch element.content.first {
            case .element, .data, .none: XCTFail("Unexpected content")
            case .string(let string): XCTAssertEqual(string, expectedString)
            }
            delegateExp.fulfill()
        }
        sut.parser(xmlParser, foundCharacters: expectedString)
        try sut.didCompleteParsing(missingConstant: { _ in }, missingElement: { _ in })
        wait(forExpectation: delegateExp)
    }

    func test_didCompleteParsing_whenDataFound_shouldAppendToElementContent() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        let expectedData = "https://advert.tracking.com?id=1234&event=firstQuartile".data(using: .utf8)!
        mockDelegate.didParseListener = { _, element in
            switch element.content.first {
            case .element, .string, .none: XCTFail("Unexpected content")
            case .data(let data): XCTAssertEqual(data, expectedData)
            }
            delegateExp.fulfill()
        }
        sut.parser(xmlParser, foundCDATA: expectedData)
        try sut.didCompleteParsing(missingConstant: { _ in }, missingElement: { _ in })
        wait(forExpectation: delegateExp)
    }

    func test_didCompleteParsing_shouldNotThrow() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        mockDelegate.didParseListener = { _, _ in
            delegateExp.fulfill()
        }
        try sut.didCompleteParsing(
            missingConstant: { _ in throw NSError(domain: "Test", code: 1, userInfo: nil) },
            missingElement: { _ in throw NSError(domain: "Test", code: 1, userInfo: nil) }
        )
        wait(forExpectation: delegateExp)
    }
}
