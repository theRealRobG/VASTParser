import Foundation

extension VAST.Parsing.AnyElementParser: UnknownElementParsingContextDelegate {
    public func unknownElementParsingContext(
        _ parsingContext: VAST.Parsing.UnknownElementParsingContext,
        didParse parsedContent: VAST.Parsing.UnknownElement
    ) {
        guard currentParsingContext === parsingContext else { return }
        defer { currentParsingContext = nil }
        guard let content = parsedContent.stringContent else { return }
        switch parsedContent.name {
        case .vastElementName.companionClickThrough,
                .vastElementName.error,
                .vastElementName.iconClickThrough,
                .vastElementName.iconViewTracking,
                .vastElementName.iFrameResource,
                .vastElementName.nonLinearClickThrough,
                .vastElementName.notViewable,
                .vastElementName.vastAdTagURI,
                .vastElementName.viewable,
                .vastElementName.viewUndetermined:
            if let url = URL(string: content), let element = url as? T {
                self.element = element
            }
        case .vastElementName.duration:
            let duration = DurationString(stringLiteral: content)
            if let element = duration as? T {
                self.element = element
            }
        case .vastElementName.expires:
            if let int = Int(content), let element = int as? T {
                self.element = element
            }
        default:
            if let element = content as? T {
                self.element = element
            }
        }
    }
}
