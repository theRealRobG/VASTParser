import Foundation

public extension VAST.Parsing {
    struct DefaultConstants {
        public var string: String
        public var int: Int
        public var double: Double
        public var url: URL
        public var data: Data

        public init(
            string: String = "",
            int: Int = -1,
            double: Double = -1,
            url: URL = URL(string: "about:blank")!,
            data: Data = Data()
        ) {
            self.string = string
            self.int = int
            self.double = double
            self.url = url
            self.data = data
        }
    }
}
