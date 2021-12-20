import VASTParser
import Foundation

let anyParserErrorLogUserInfoKey = "anyParserErrorLogUserInfoKey"

class AnyParser<T>: NSObject, XMLParserDelegate {
    let elementName: String
    let behaviour: VAST.Parsing.Behaviour
    let errorLog = VAST.Parsing.ErrorLog()
    var element: T?
    var currentParsingContext: VAST.Parsing.AnyParsingContext?

    convenience init(
        elementType: T.Type = T.self,
        behaviour: VAST.Parsing.Behaviour = VAST.Parsing.Behaviour(strictness: .loose)
    ) {
        self.init(
            elementName: "\(elementType)".split(separator: ".").map { String($0) }.last ?? "\(elementType)",
            behaviour: behaviour
        )
    }

    init(
        elementName: String,
        behaviour: VAST.Parsing.Behaviour = VAST.Parsing.Behaviour(strictness: .loose)
    ) {
        self.elementName = elementName
        self.behaviour = behaviour
    }

    func parse(_ string: String) throws -> T {
        guard let data = string.data(using: .utf8) else {
            throw NSError(domain: "AnyParserError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data in string"])
        }
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        guard let element = self.element else { throw error(xmlParser) }
        return element
    }

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        switch elementName {
        case .vastElementName.adParameters:
            currentParsingContext = VAST.Parsing.AdParametersParsingContext(
                xmlParser: parser,
                attributes: attributeDict,
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: self,
                parentContext: self
            )
        case .vastElementName.adSystem:
            currentParsingContext = VAST.Parsing.AdSystemParsingContext(
                xmlParser: parser,
                attributes: attributeDict,
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: self,
                parentContext: self
            )
        default:
            break
        }
    }

    private func error(_ parser: XMLParser) -> Error {
        let e = (parser.parserError ?? NSError(domain: "AnyParserError", code: 1, userInfo: [:])) as NSError
        var updatedUserInfo = e.userInfo
        updatedUserInfo[anyParserErrorLogUserInfoKey] = errorLog.items
        return NSError(domain: e.domain, code: e.code, userInfo: updatedUserInfo)
    }
}
