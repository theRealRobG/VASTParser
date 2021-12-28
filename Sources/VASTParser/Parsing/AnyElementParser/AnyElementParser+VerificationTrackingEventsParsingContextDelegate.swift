extension VAST.Parsing.AnyElementParser: VerificationTrackingEventsParsingContextDelegate {
    public func trackingEventsParsingContext(
        _ parsingContext: VAST.Parsing.Verification.TrackingEventsParsingContext,
        didParse parsedContent: [VAST.Element.Verification.Tracking]
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
