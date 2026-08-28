extension Comparison {

    @inlinable
    public func then(_ other: Comparison) -> Comparison {
        switch self {
        case .equal: return other
        case .less, .greater: return self
        }
    }

    @inlinable
    public func then(with other: () -> Comparison) -> Comparison {
        switch self {
        case .equal: return other()
        case .less, .greater: return self
        }
    }
}
