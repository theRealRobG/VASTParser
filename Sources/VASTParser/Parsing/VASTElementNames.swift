struct VASTElementNames {
    static let ad = "Ad"
    static let adParameters = "AdParameters"
    static let adServingId = "AdServingId"
    static let adSystem = "AdSystem"
    static let adTitle = "AdTitle"
    static let adVerifications = "AdVerifications"
    static let advertiser = "Advertiser"
    static let altText = "AltText"
    static let blockedAdCategories = "BlockedAdCategories"
    static let category = "Category"
    static let clickThrough = "ClickThrough"
    static let clickTracking = "ClickTracking"
    static let closedCaptionFile = "ClosedCaptionFile"
    static let closedCaptionFiles = "ClosedCaptionFiles"
    static let companion = "Companion"
    static let companionAds = "CompanionAds"
    static let companionClickThrough = "CompanionClickThrough"
    static let companionClickTracking = "CompanionClickTracking"
    static let creative = "Creative"
    static let creativeExtension = "CreativeExtension"
    static let creativeExtensions = "CreativeExtensions"
    static let creatives = "Creatives"
    static let customClick = "CustomClick"
    static let description = "Description"
    static let duration = "Duration"
    static let error = "Error"
    static let executableResource = "ExecutableResource"
    static let expires = "Expires"
    static let `extension` = "Extension"
    static let extensions = "Extensions"
    static let htmlResource = "HTMLResource"
    static let iFrameResource = "IFrameResource"
    static let icon = "Icon"
    static let iconClickFallbackImage = "IconClickFallbackImage"
    static let iconClickFallbackImages = "IconClickFallbackImages"
    static let iconClickThrough = "IconClickThrough"
    static let iconClickTracking = "IconClickTracking"
    static let iconClicks = "IconClicks"
    static let iconViewTracking = "IconViewTracking"
    static let icons = "Icons"
    static let impression = "Impression"
    static let inLine = "InLine"
    static let interactiveCreativeFile = "InteractiveCreativeFile"
    static let javaScriptResource = "JavaScriptResource"
    static let linear = "Linear"
    static let mediaFile = "MediaFile"
    static let mediaFiles = "MediaFiles"
    static let mezzanine = "Mezzanine"
    static let nonLinear = "NonLinear"
    static let nonLinearAds = "NonLinearAds"
    static let nonLinearClickThrough = "NonLinearClickThrough"
    static let nonLinearclickTracking = "NonLinearclickTracking"
    static let notViewable = "NotViewable"
    static let pricing = "Pricing"
    static let staticResource = "StaticResource"
    static let survey = "Survey"
    static let tracking = "Tracking"
    static let trackingEvents = "TrackingEvents"
    static let universalAdId = "UniversalAdId"
    static let vastAdTagURI = "VASTAdTagURI"
    static let verification = "Verification"
    static let verificationParameters = "VerificationParameters"
    static let videoClicks = "VideoClicks"
    static let viewUndetermined = "ViewUndetermined"
    static let viewable = "Viewable"
    static let viewableImpression = "ViewableImpression"
    static let wrapper = "Wrapper"
}

extension String {
    static var vastElementNames: VASTElementNames.Type { VASTElementNames.self }
}

import Foundation

class AnyParsingContext: NSObject, XMLParserDelegate {
    let elementName: String
    let attributes: [String: String]
    var delegate: Any?
    weak var parentContext: XMLParserDelegate?

    init(
        xmlParser: XMLParser,
        elementName: String,
        attributes: [String: String],
        delegate: Any,
        parentContext: XMLParserDelegate?
    ) {
        self.elementName = elementName
        self.attributes = attributes
        self.delegate = delegate
        self.parentContext = parentContext
        super.init()
        xmlParser.delegate = self
    }

    func didCompleteParsing() {
        fatalError("Must be implemented in subclass")
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        guard elementName == self.elementName else { return }
        didCompleteParsing()
        unlink(parser)
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        didCompleteParsing()
        unlink(parser)
    }

    private func unlink(_ parser: XMLParser) {
        parser.delegate = parentContext
        delegate = nil
        parentContext = nil
    }
}

protocol StringContentParsingContextDelegate: AnyObject {
    func stringContentParsingContext(
        _ parsingContext: StringContentParsingContext,
        didParse content: String,
        fromElementName elementName: String
    )
}

class StringContentParsingContext: AnyParsingContext {
    var content: String?

    var localDelegate: StringContentParsingContextDelegate? { super.delegate as? StringContentParsingContextDelegate }

    init(
        xmlParser: XMLParser,
        elementName: String,
        attributes: [String: String],
        delegate: StringContentParsingContextDelegate,
        parentContext: XMLParserDelegate?
    ) {
        super.init(
            xmlParser: xmlParser,
            elementName: elementName,
            attributes: attributes,
            delegate: delegate,
            parentContext: parentContext
        )
    }

    override func didCompleteParsing() {
        if let content = content {
            localDelegate?.stringContentParsingContext(self, didParse: content, fromElementName: elementName)
        }
    }

    @objc func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.content = string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

protocol ImpressionParsingContextDelegate: AnyObject {
    func impressionParsingContext(
        _ parsingContext: ImpressionParsingContext,
        didParse content: VAST.Element.Impression,
        fromElementName elementName: String
    )
}

class ImpressionParsingContext: AnyParsingContext {
    var url: VAST.Element.Impression.Content?

    var localDelegate: ImpressionParsingContextDelegate? { super.delegate as? ImpressionParsingContextDelegate }

    init(
        xmlParser: XMLParser,
        elementName: String,
        attributes: [String: String],
        delegate: ImpressionParsingContextDelegate,
        parentContext: XMLParserDelegate?
    ) {
        super.init(
            xmlParser: xmlParser,
            elementName: elementName,
            attributes: attributes,
            delegate: delegate,
            parentContext: parentContext
        )
    }

    override func didCompleteParsing() {
        guard let id = attributes["id"], let url = self.url else { return }
        localDelegate?.impressionParsingContext(
            self,
            didParse: VAST.Element.Impression(id: id, content: url),
            fromElementName: elementName
        )
    }

    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        self.url = String(data: CDATABlock, encoding: .utf8).flatMap {
            VAST.Element.Impression.Content($0.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
}

protocol InlineParsingContextDelegate: AnyObject {
    func inlineParsingContext(
        _ parsingContext: InlineParsingContext,
        didParse content: VAST.Element.InLine,
        fromElementName elementName: String
    )
}

class InlineParsingContext: AnyParsingContext {
    var adSystem: VAST.Element.AdSystem?
    var adTitle: VAST.Element.AdTitle?
    var error: VAST.Element.Error?
    var impressions = [VAST.Element.Impression]()

    var localDelegate: InlineParsingContextDelegate? { super.delegate as? InlineParsingContextDelegate }

    private var currentStringParsingContext: StringContentParsingContext?
    private var currentImpressionParsingContext: ImpressionParsingContext?

    init(
        xmlParser: XMLParser,
        elementName: String,
        attributes: [String: String],
        delegate: InlineParsingContextDelegate,
        parentContext: XMLParserDelegate?
    ) {
        super.init(
            xmlParser: xmlParser,
            elementName: elementName,
            attributes: attributes,
            delegate: delegate,
            parentContext: parentContext
        )
    }

    override func didCompleteParsing() {
        guard let adSystem = self.adSystem, let adTitle = self.adTitle, let error = self.error else { return }
        localDelegate?.inlineParsingContext(
            self,
            didParse: VAST.Element.InLine(
                adSystem: adSystem,
                adTitle: adTitle,
                impression: impressions,
                adServingId: VAST.Element.AdServingId(content: ""),
                creatives: VAST.Element.Creatives(creative: []),
                category: nil,
                description: nil,
                advertiser: nil,
                pricing: nil,
                survey: nil,
                error: error,
                extensions: nil,
                viewableImpression: nil,
                adVerifications: nil,
                expires: nil
            ),
            fromElementName: elementName
        )
    }

    @objc func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        switch elementName {
        case .vastElementNames.adSystem, .vastElementNames.adTitle, .vastElementNames.error:
            self.currentStringParsingContext = StringContentParsingContext(
                xmlParser: parser,
                elementName: elementName,
                attributes: attributeDict,
                delegate: self,
                parentContext: self
            )
        case .vastElementNames.impression:
            self.currentImpressionParsingContext = ImpressionParsingContext(
                xmlParser: parser,
                elementName: elementName,
                attributes: attributeDict,
                delegate: self,
                parentContext: self
            )
        default:
            break
        }
    }
}

extension InlineParsingContext: StringContentParsingContextDelegate {
    func stringContentParsingContext(
        _ parsingContext: StringContentParsingContext,
        didParse content: String,
        fromElementName elementName: String
    ) {
        switch elementName {
        case .vastElementNames.adSystem:
            self.adSystem = VAST.Element.AdSystem(version: "", content: content)
        case .vastElementNames.adTitle:
            self.adTitle = VAST.Element.AdTitle(content: content)
        case .vastElementNames.error:
            self.error = URL(string: content).map { VAST.Element.Error(content: $0) }
        default:
            break
        }
        self.currentStringParsingContext = nil
    }
}

extension InlineParsingContext: ImpressionParsingContextDelegate {
    func impressionParsingContext(
        _ parsingContext: ImpressionParsingContext,
        didParse content: VAST.Element.Impression,
        fromElementName elementName: String
    ) {
        impressions.append(content)
        self.currentImpressionParsingContext = nil
    }
}

class Test: NSObject, InlineParsingContextDelegate, XMLParserDelegate {
    var inline: VAST.Element.InLine?

    private var currentInlineParsingContext: InlineParsingContext?

    func parse(xmlString: String) throws -> VAST.Element.InLine {
        guard let data = xmlString.data(using: .utf8) else {
            throw NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "XML was not Data"])
        }
        return try parse(data: data)
    }

    func parse(data: Data) throws -> VAST.Element.InLine {
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        guard let inline = self.inline else {
            throw NSError(domain: "Test", code: 2, userInfo: [NSLocalizedDescriptionKey: "Did not parse impression"])
        }
        return inline
    }

    func inlineParsingContext(
        _ parsingContext: InlineParsingContext,
        didParse content: VAST.Element.InLine,
        fromElementName elementName: String
    ) {
        self.inline = content
        currentInlineParsingContext = nil
    }

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        guard elementName == .vastElementNames.inLine else { return }
        currentInlineParsingContext = InlineParsingContext(
            xmlParser: parser,
            elementName: elementName,
            attributes: attributeDict,
            delegate: self,
            parentContext: self
        )
    }
}

