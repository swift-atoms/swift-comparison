public import Comparison

#if !hasFeature(Embedded)
    extension Comparison: Codable {

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            switch value {
            case "less": self = .less
            case "equal": self = .equal
            case "greater": self = .greater

            default:
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Expected 'less', 'equal', or 'greater', got '\(value)'"
                )
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .less: try container.encode("less")
            case .equal: try container.encode("equal")
            case .greater: try container.encode("greater")
            }
        }
    }
#endif
