public extension VAST.Element {
    /// The ad server may provide URIs for tracking publisher-determined viewability, for both the InLine ad
    /// and any Wrappers, using the `<ViewableImpression>` element. Tracking URIs may be
    /// provided in three containers: `<Viewable>`, `<NotViewable>`, and
    /// `<ViewUndetermined>`.
    ///
    /// The point at which these tracking resource files are pinged depends on the viewability standard the
    /// player has implemented, in agreement with or with the understanding of the buyer.
    ///
    /// Player support for the `<ViewableImpression>` element is optional. When used, URIs for the
    /// Inline ad as well as any wrappers used to serve the ad should all be triggered at the same time, or
    /// as close in time as possible to when the criteria for the individual event is met.
    ///
    /// Note – ViewableImpression is not applicable for Audio use cases.
    struct ViewableImpression {
        /// An ad server id for the impression. Viewable impression resources of the same id should be
        /// requested at the same time, or as close in time as possible, to help prevent discrepancies.
        public let id: String
        /// The `<Viewable>` element is used to place a URI that the player triggers if and when the
        /// ad meets criteria for a viewable video ad impression.
        public let viewable: [Viewable]
        /// The `<NotViewable>` element is a container for placing a URI that the player triggers if
        /// the ad is executed but never meets criteria for a viewable video ad impression.
        public let notViewable: [NotViewable]
        /// The `<ViewUndetermined>` element is a container for placing a URI that the player
        /// triggers if it cannot determine whether the ad has met criteria for a viewable video ad
        /// impression.
        public let viewUndetermined: [ViewUndetermined]

        public init(
            id: String,
            viewable: [Viewable],
            notViewable: [NotViewable],
            viewUndetermined: [ViewUndetermined]
        ) {
            self.id = id
            self.viewable = viewable
            self.notViewable = notViewable
            self.viewUndetermined = viewUndetermined
        }
    }
}
