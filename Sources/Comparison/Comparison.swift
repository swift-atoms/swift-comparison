public enum Comparison: Sendable, Hashable, CaseIterable {

    case less

    case equal

    case greater
}

#if !hasFeature(Embedded)
extension Comparison: Swift.Codable {}
#endif
