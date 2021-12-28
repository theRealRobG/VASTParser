import Foundation

public extension VAST.Parsing {
    static var anyElementParserErrorLogUserInfoKey: String { "anyElementParserErrorLogUserInfoKey" }

    class AnyElementParser<T>: NSObject, XMLParserDelegate {
        let elementName: String
        let behaviour: VAST.Parsing.Behaviour
        let errorLog = VAST.Parsing.ErrorLog()
        var element: T?
        var currentParsingContext: VAST.Parsing.AnyParsingContext?

        public convenience init(
            elementType: T.Type = T.self,
            behaviour: VAST.Parsing.Behaviour = VAST.Parsing.Behaviour(strictness: .default)
        ) {
            self.init(
                elementName: "\(elementType)".split(separator: ".").map { String($0) }.last ?? "\(elementType)",
                behaviour: behaviour
            )
        }

        public init(
            elementName: String,
            behaviour: VAST.Parsing.Behaviour = VAST.Parsing.Behaviour(strictness: .default)
        ) {
            self.elementName = elementName
            self.behaviour = behaviour
        }

        public func parse(_ string: String) throws -> T {
            guard let data = string.data(using: .utf8) else {
                throw NSError(
                    domain: "AnyParserError",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "No data in string"]
                )
            }
            let xmlParser = XMLParser(data: data)
            xmlParser.delegate = self
            xmlParser.parse()
            guard let element = self.element else { throw error(xmlParser) }
            return element
        }

        public func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            namespaceURI: String?,
            qualifiedName qName: String?,
            attributes attributeDict: [String : String] = [:]
        ) {
            switch elementName {
            // MARK: - Simple content elements
            case .vastElementName.adServingId,
                    .vastElementName.adTitle,
                    .vastElementName.altText,
                    .vastElementName.companionClickThrough,
                    .vastElementName.description,
                    .vastElementName.duration,
                    .vastElementName.error,
                    .vastElementName.expires,
                    .vastElementName.htmlResource,
                    .vastElementName.iconClickThrough,
                    .vastElementName.iconViewTracking,
                    .vastElementName.iFrameResource,
                    .vastElementName.nonLinearClickThrough,
                    .vastElementName.notViewable,
                    .vastElementName.vastAdTagURI,
                    .vastElementName.verificationParameters,
                    .vastElementName.viewable,
                    .vastElementName.viewUndetermined:
                currentParsingContext = VAST.Parsing.UnknownElementParsingContext(
                    xmlParser: parser,
                    elementName: elementName,
                    attributes: [:],
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            // MARK: - Complex elements (including attributes and/or children)
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
            case .vastElementName.advertiser:
                currentParsingContext = VAST.Parsing.AdvertiserParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.blockedAdCategories:
                currentParsingContext = VAST.Parsing.BlockedAdCategoriesParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.category:
                currentParsingContext = VAST.Parsing.CategoryParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.clickThrough:
                currentParsingContext = VAST.Parsing.ClickThroughParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.clickTracking:
                currentParsingContext = VAST.Parsing.ClickTrackingParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.closedCaptionFile:
                currentParsingContext = VAST.Parsing.ClosedCaptionFileParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.closedCaptionFiles:
                currentParsingContext = VAST.Parsing.ClosedCaptionFilesParsingContext(
                    xmlParser: parser,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.executableResource:
                currentParsingContext = VAST.Parsing.ExecutableResourceParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.impression:
                currentParsingContext = VAST.Parsing.ImpressionParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.javaScriptResource:
                currentParsingContext = VAST.Parsing.JavaScriptResourceParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.trackingEvents:
                if T.self is VAST.Element.Verification.TrackingEvents.Type {
                    currentParsingContext = VAST.Parsing.Verification.TrackingEventsParsingContext(
                        xmlParser: parser,
                        errorLog: errorLog,
                        behaviour: behaviour,
                        delegate: self,
                        parentContext: self
                    )
                }
            case .vastElementName.verification:
                currentParsingContext = VAST.Parsing.VerificationParsingContext(
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
            updatedUserInfo[VAST.Parsing.anyElementParserErrorLogUserInfoKey] = errorLog.items
            return NSError(domain: e.domain, code: e.code, userInfo: updatedUserInfo)
        }
    }
}
