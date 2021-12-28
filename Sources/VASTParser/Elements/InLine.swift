public extension VAST.Element {
    /// Within the nested elements of an `<InLine>` ad are all the files and URIs necessary to play and
    /// track the ad. In a chain of `<Wrapper>` VAST responses, an `<InLine>` response ends the
    /// chain.
    struct InLine {
        /// The ad serving party must provide a descriptive name for the system that serves the ad.
        /// Optionally, a version number for the ad system may also be provided using the version
        /// attribute.
        public let adSystem: AdSystem
        /// A string that provides a common name for the ad.
        ///
        /// The ad serving party must provide a title for the ad using the `<AdTitle>` element. If a longer
        /// description is needed, the `<Description>` element can be used.
        public let adTitle: AdTitle
        /// The ad server provides an impression-tracking URI for either the InLine ad or the Wrapper
        /// using the `<Impression>` element. All `<Impression>` URIs in the InLine response and any
        /// Wrapper responses preceding it should be triggered at the same time when the impression
        /// for the ad occurs, or as close in time as possible to when the impression occurs, to prevent
        /// impression-counting discrepancies.
        public let impression: [Impression]
        /// A unique or pseudo-unique (long enough to be unique when combined with timestamp data)
        /// GUID.
        ///
        /// Any ad server that returns a VAST containing an `<InLine>` ad must generate a pseudo-
        /// unique identifier that is appropriate for all involved parties to track the lifecycle of that ad.
        /// This should be inserted into the `<AdServingId>` element, and also be included on all
        /// outgoing tracking pixels. The purpose of this id is to greatly reduce the amount of work
        /// required to compare impression-level data across multiple systems, which is otherwise done
        /// by passing proprietary IDs across different systems and matching them.
        public let adServingId: AdServingId
        /// The `<Creatives>` (plural) element is a container for one or more `<Creative>` (singular)
        /// element used to provide creative files for the ad. For an InLine ad, the `<Creatives>` element
        /// nests all the files necessary for executing and tracking the ad.
        ///
        /// In a Wrapper, elements nested under `<Creatives>` are used mostly for tracking.
        /// Companion and Icon creative may be included in a Wrapper, but files for Linear and
        /// NonLinear ads can only be provided in the InLine version of the ad.
        public let creatives: Creatives
        /// Used in creative separation and for compliance in certain programs, a category field is
        /// needed to categorize the ad’s content. Several category lists exist, some for describing site
        /// content and some for describing ad content. Some lists are used interchangeably for both
        /// site content and ad content. For example, the category list used to comply with the IAB
        /// Quality Assurance Guidelines (QAG) describes site content, but is sometimes used to describe
        /// ad content.
        public let category: [Category]
        /// A string that provides a long ad description
        ///
        /// When a longer description of the ad is needed, the `<Description>` element can be used.
        public let description: Description?
        /// Providing an advertiser name can help publishers prevent display of the ad with its
        /// competitors. Ad serving parties and publishers should identify how to interpret values
        /// provided within this element.
        public let advertiser: Advertiser?
        /// Used to provide a value that represents a price that can be used by real-time bidding (RTB)
        /// systems. VAST is not designed to handle RTB since other methods exist, but this element
        /// is offered for custom solutions if needed. If the value provided is to be obfuscated or
        /// encoded, publishers and advertisers must negotiate the appropriate mechanism to do so.
        public let pricing: Pricing?
        /// The survey node is deprecated in VAST 4.1, since usage was very limited and survey
        /// implementations can be supported by other VAST elements such as 3rd party trackers.
        ///
        /// Ad tech vendors may want to use the ad to collect data for resource purposes. The
        /// `<Survey>` element can be used to provide a URI to any resource file having to do with
        /// collecting survey data. Publishers and any parties using the `<Survey>` element should
        /// determine how surveys are implemented and executed. Multiple survey elements may be
        /// provided.
        public let survey: [Survey]
        /// A URI supplied by the ad server and used to report the no ad response.
        ///
        /// The `<Error>` element contains a URI that the player uses to notify the ad server when
        /// errors occur with ad playback. If the URI contains an `[ERRORCODE]` macro, the media player
        /// must populate the macro with an error code as defined in section 2.3.6.
        ///
        /// If no specific error can be found, error `900` may be used to indicate an undefined error;
        /// however, every attempt should be made to provide an error code that maps to the error that
        /// occurred. The `<Error>` element is available for both the `InLine` or `Wrapper` elements.
        public let error: [Error]
        /// Ad servers can use this XML node for custom extensions of VAST. When used, custom XML
        /// should fall under the nested `<Extension>` (singular) element so that custom XML can be
        /// separated from VAST elements. An XML namespace (xmlns) should also be used for the
        /// custom extension to separate it from VAST components.
        public let extensions: Extensions?
        /// The ad server may provide URIs for tracking publisher-determined viewability, for both the
        /// InLine ad and any Wrappers, using the `<ViewableImpression>` element. Tracking URIs
        /// may be provided in three containers: `<Viewable>`, `<NotViewable>`, and
        /// `<ViewUndetermined>`.
        ///
        /// The point at which these tracking resource files are pinged depends on the viewability
        /// standard the player has implemented, in agreement with or with the understanding of the
        /// buyer.
        ///
        /// Player support for the `<ViewableImpression>` element is optional. When used, URIs for the
        /// Inline ad as well as any wrappers used to serve the ad should all be triggered at the same
        /// time, or as close in time as possible to when the criteria for the individual event is met.
        public let viewableImpression: ViewableImpression?
        /// The `<AdVerifications>` element contains one or more `<Verification>` elements,
        /// which list the resources and metadata required to execute third-party measurement code in
        /// order to verify creative playback.The `<AdVerifications>` element is used to contain one
        /// or more `<Verification>` elements, which are used to initiate a controlled container
        /// where code can be executed for collecting data to verify ad playback details.
        public let adVerifications: AdVerifications?
        /// An integer value that defines the expiry period (in seconds).
        ///
        /// The number of seconds in which the ad is valid for execution. In cases where the ad is
        /// requested ahead of time, this timing indicates how many seconds after the request that the
        /// ad expires and cannot be played. This element is useful for preventing an ad from playing
        /// after a timeout has occurred.
        public let expires: Expires?

        public init(
            adSystem: AdSystem,
            adTitle: AdTitle,
            impression: [Impression],
            adServingId: AdServingId,
            creatives: Creatives,
            category: [Category],
            description: Description?,
            advertiser: Advertiser?,
            pricing: Pricing?,
            survey: [Survey],
            error: [Error],
            extensions: Extensions?,
            viewableImpression: ViewableImpression?,
            adVerifications: AdVerifications?,
            expires: Expires?
        ) {
            self.adSystem = adSystem
            self.adTitle = adTitle
            self.impression = impression
            self.adServingId = adServingId
            self.creatives = creatives
            self.category = category
            self.description = description
            self.advertiser = advertiser
            self.pricing = pricing
            self.survey = survey
            self.error = error
            self.extensions = extensions
            self.viewableImpression = viewableImpression
            self.adVerifications = adVerifications
            self.expires = expires
        }
    }
}
