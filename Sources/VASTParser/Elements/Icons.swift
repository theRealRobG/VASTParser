public extension VAST.Element {
    /// The industry icon feature was defined in VAST 3.0 to support initiatives such as privacy programs. An
    /// example of such a program is the AdChoices program for interest-based advertising (IBA). Though the VAST
    /// icon feature was initially created to support privacy programs, it was designed to support other programs
    /// that require posting an icon with the linear ad.
    ///
    /// This feature is only offered for Linear Ads because icons can be easily inserted in NonLinear ads and
    /// companion creative using existing features. Icon source files may also be included in a wrapper if
    /// necessary.
    struct Icons {
        /// Nested under the `<Icons>` element, the Icon is used to provide one or more creative files for the icon that
        /// represents the program being implemented along with any icon tracking elements. Multiple `<Icon>` elements
        /// may be used to represent multiple programs.
        public let icon: [Icon]

        public init(icon: [Icon]) {
            self.icon = icon
        }
    }
}
