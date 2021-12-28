import Foundation

public extension VAST.Parsing {
    class UnknownElement: CustomStringConvertible {
        /// The name of the unknown element.
        public let name: String
        /// Any content found within the unknown element.
        public var content: [UnknownElementContent] = []
        /// Any attributes that exist on the unknown element.
        public var attributes: [String: String] = [:]

        /// A string representation of the unknown element in an XML format.
        ///
        /// For example, if we have the following `UnknownElement`:
        /// ```
        /// let parent = UnknownElement(name: "Parent", attributes: ["name": "Foo"])
        /// let child = UnknownElement(name: "Child", attributes: [:])
        /// parent.content.append(.element(child))
        /// ```
        /// Then the description should look like:
        /// ```
        /// <Parent name="Foo"><Child></Child></Parent>
        /// ```
        public var description: String {
            var xmlString = "<\(name)"
            xmlString += attributes.isEmpty ? "" : " "
            xmlString += attributes
                .map { key, value in
                    return "\(key)=\"\(value)\""
                }
                .joined(separator: " ")
            xmlString += ">"
            for element in content {
                switch element {
                case .element(let unknownElement):
                    xmlString += unknownElement.description
                case .string(let string):
                    xmlString += string.trimmingCharacters(in: .whitespacesAndNewlines)
                case .data(let data):
                    guard let string = String(data: data, encoding: .utf8) else { continue }
                    xmlString += string.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            xmlString += "</\(name)>"
            return xmlString
        }

        /// A convenience accessor for just the string data that we can obtain from the String and Data content
        /// elements. Any string data found within a child element is not considered for `stringContent`.
        ///
        /// For example, the following structure:
        /// ```
        /// let p = UnknownElement(name: "P", attributes: [:])
        /// p.content.append(.string("Hello, "))
        /// let span = UnknownElement(name: "span", attributes: ["style": "font-weight:bold"])
        /// span.content.append(.string("World"))
        /// p.content.append(.element(span))
        /// p.content.append(.string("!"))
        /// ```
        /// Will  yield the following `stringContent`:
        /// ```
        /// "Hello, !"
        /// ```
        ///
        /// As such, this convenience accessor is most useful when used without mixed element and data content, and so
        /// best used when parsing elements that expect just characters or CDATA (and not sub-elements).
        public var stringContent: String? {
            let stringContent = content
                .reduce("") { existingContent, nextContentElement in
                    switch nextContentElement {
                    case .data(let data):
                        guard let string = String(data: data, encoding: .utf8) else { return existingContent }
                        return existingContent + string
                    case .element:
                        return existingContent
                    case .string(let string):
                        return existingContent + string
                    }
                }
                .trimmingCharacters(in: .whitespacesAndNewlines)

            if stringContent.isEmpty {
                return nil
            } else {
                return stringContent
            }
        }

        public init(name: String, attributes: [String: String] = [:]) {
            self.name = name
            self.attributes = attributes
        }
    }

    enum UnknownElementContent {
        case element(UnknownElement)
        case string(String)
        case data(Data)
    }
}
