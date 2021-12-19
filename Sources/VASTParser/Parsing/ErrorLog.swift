public extension VAST.Parsing {
    class ErrorLog {
        public var items: [VASTParsingError] { log }

        private var log = [VASTParsingError]()

        public init() {}

        public func append(_ error: VASTParsingError) {
            log.append(error)
        }
    }
}
