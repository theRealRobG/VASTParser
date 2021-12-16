public extension VAST.Element {
    struct Ad {
        /// The Ad element requires exactly one child, which can either be an `<InLine>` or
        /// `<Wrapper>` element.
        public let content: Ad.Content
        /// An ad server-defined identifier string for the ad
        public let id: String
        /// An integer greater than zero (0) that identifies the sequence in which an ad should
        /// play; all `<Ad>` elements with sequence values are part of a pod and are intended to be
        /// played in sequence
        public let sequence: Int
        /// **[Deprecated in VAST 4.1, along with apiFramework]**
        /// A Boolean that identifies a conditional ad. In the case of programmatic ad serving,
        /// a VPAID ad unit or other mechanism might be used to decide whether there is an ad
        /// that matches the placement. When there is no match, an ad may not be served. Use
        /// of the `conditionalAd` attribute enables publishers to avoid accepting these ads
        /// in placements where an ad must be served. A value of `true` indicates that the ad is
        /// conditional and should be used in all cases where the InLine executable unit (such as
        /// VPAID) is not an ad but is instead a framework for finding an ad; a value of
        /// `false` is the default value and indicates that an ad is available.
        public let conditionalAd: Bool
        /// An optional string that identifies the type of ad. This allows VAST to support audio ad
        /// scenarios.
        public let adType: AdType
        
        public init(
            content: Ad.Content,
            id: String,
            sequence: Int,
            conditionalAd: Bool = false,
            adType: AdType = .video
        ) {
            self.content = content
            self.id = id
            self.sequence = sequence
            self.conditionalAd = conditionalAd
            self.adType = adType
        }
    }
}

public extension VAST.Element.Ad {
    enum Content {
        case inLine(VAST.Element.InLine)
        case wrapper(VAST.Element.Wrapper)
    }
    
    enum AdType: String {
        case video
        case audio
        case hybrid
    }
}
