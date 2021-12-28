import VASTParser
import Foundation
import XCTest

private let verificationParametersExample = """
<VerificationParameters><![CDATA[param=test]]></VerificationParameters>
"""

private class MockCDATAContentParsingContextDelegate: CDATAContentParsingContextDelegate {
    var didParseListener: ((VAST.Parsing.CDATAContentParsingContext, Data, String) -> Void)?

    func cdataContentParsingContext(
        _ parsingContext: VAST.Parsing.CDATAContentParsingContext,
        didParse content: Data,
        fromElementName elementName: String
    ) {
        didParseListener?(parsingContext, content, elementName)
    }
}

class CDATAContentParsingContextTests: XCTestCase {
    var sut: VAST.Parsing.CDATAContentParsingContext!
    var xmlParser: XMLParser!
    var elementName: String!
    var errorLog: VAST.Parsing.ErrorLog!
    let defaultData = "TEST_STRING".data(using: .utf8)!
    var behaviour: VAST.Parsing.Behaviour!
    private var mockDelegate: MockCDATAContentParsingContextDelegate!

    override func setUp() {
        xmlParser = XMLParser()
        elementName = "SomeElement"
        errorLog = VAST.Parsing.ErrorLog()
        behaviour = VAST.Parsing.Behaviour(defaults: VAST.Parsing.DefaultConstants(data: defaultData))
        mockDelegate = MockCDATAContentParsingContextDelegate()
        sut = VAST.Parsing.CDATAContentParsingContext(
            xmlParser: xmlParser,
            elementName: elementName,
            errorLog: errorLog,
            behaviour: behaviour,
            delegate: mockDelegate,
            parentContext: nil
        )
    }

    func test_didCompleteParsing_whenDataFound_shouldNotifyDelegateWithData() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        let expectedData = "some data".data(using: .utf8)!
        mockDelegate.didParseListener = { context, data, name in
            XCTAssert(context === self.sut)
            XCTAssertEqual(data, expectedData)
            XCTAssertEqual(name, self.elementName)
            delegateExp.fulfill()
        }
        sut.parser(xmlParser, foundCDATA: expectedData)
        try sut.didCompleteParsing(missingConstant: { _ in }, missingElement: { _ in })
        wait(forExpectation: delegateExp)
    }

    func test_didCompleteParsing_whenNoDataFound_ifMissingContentThrows_shouldThrow() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        delegateExp.isInverted = true
        mockDelegate.didParseListener = { _, _, _ in
            delegateExp.fulfill()
        }
        let expectedError = VASTParsingError.missingRequiredProperty(
            parentElementName: elementName,
            missingPropertyName: "content"
        )
        XCTAssertThrowsError(
            try sut.didCompleteParsing(
                missingConstant: { _ in throw expectedError },
                missingElement: { _ in }
            )
        ) { error in
            XCTAssertEqual(error as? VASTParsingError, expectedError)
        }
        wait(forExpectation: delegateExp)
    }

    func test_didCompleteParsing_whenNoDataFound_ifMissingContentNoThrows_shouldCompleteWithDefault() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        mockDelegate.didParseListener = { _, content, _ in
            XCTAssertEqual(content, self.defaultData)
            delegateExp.fulfill()
        }
        XCTAssertNoThrow(try sut.didCompleteParsing(missingConstant: { _ in  }, missingElement: { _ in }))
        wait(forExpectation: delegateExp)
    }

    func test_verificationParametersExample() {
        try XCTAssertEqual(
            VAST.Parsing.AnyElementParser.loose().parse(verificationParametersExample),
            "param=test".data(using: .utf8)!
        )
    }
}
