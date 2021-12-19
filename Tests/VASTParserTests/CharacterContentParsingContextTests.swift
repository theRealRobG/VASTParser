import VASTParser
import Foundation
import XCTest

private class MockCharacterContentParsingContextDelegate: CharacterContentParsingContextDelegate {
    var didParseListener: ((VAST.Parsing.CharacterContentParsingContext, String, String) -> Void)?

    func stringContentParsingContext(
        _ parsingContext: VAST.Parsing.CharacterContentParsingContext,
        didParse content: String,
        fromElementName elementName: String
    ) {
        didParseListener?(parsingContext, content, elementName)
    }
}

class CharacterContentParsingContextTests: XCTestCase {
    var sut: VAST.Parsing.CharacterContentParsingContext!
    var xmlParser: XMLParser!
    var elementName: String!
    var errorLog: VAST.Parsing.ErrorLog!
    let defaultString = "TEST_STRING"
    var behaviour: VAST.Parsing.Behaviour!
    private var mockDelegate: MockCharacterContentParsingContextDelegate!

    override func setUp() {
        xmlParser = XMLParser()
        elementName = "SomeElement"
        errorLog = VAST.Parsing.ErrorLog()
        behaviour = VAST.Parsing.Behaviour(defaults: VAST.Parsing.DefaultConstants(string: defaultString))
        mockDelegate = MockCharacterContentParsingContextDelegate()
        sut = VAST.Parsing.CharacterContentParsingContext(
            xmlParser: xmlParser,
            elementName: elementName,
            errorLog: errorLog,
            behaviour: behaviour,
            delegate: mockDelegate,
            parentContext: nil
        )
    }

    func test_didCompleteParsing_whenCharactersFound_shouldNotifyDelegateWithTrimmedCharacters() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        let characters = "   Some characters that could be within an XML node   "
        let expectedCharacters = "Some characters that could be within an XML node"
        mockDelegate.didParseListener = { context, characters, name in
            XCTAssert(context === self.sut)
            XCTAssertEqual(characters, expectedCharacters)
            XCTAssertEqual(name, self.elementName)
            delegateExp.fulfill()
        }
        sut.parser(xmlParser, foundCharacters: characters)
        try sut.didCompleteParsing(missingConstant: { _ in }, missingElement: { _ in })
        wait(forExpectation: delegateExp)
    }

    func test_didCompleteParsing_whenNoCharactersFound_ifMissingContentThrows_shouldThrow() throws {
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

    func test_didCompleteParsing_whenNoCharactersFound_ifMissingContentNoThrows_shouldCompleteWithDefault() throws {
        let delegateExp = expectation(description: "wait for inform delegate")
        mockDelegate.didParseListener = { _, content, _ in
            XCTAssertEqual(content, self.defaultString)
            delegateExp.fulfill()
        }
        XCTAssertNoThrow(try sut.didCompleteParsing(missingConstant: { _ in  }, missingElement: { _ in }))
        wait(forExpectation: delegateExp)
    }
}
