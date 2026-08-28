extension Comparison {

    @inlinable
    public var reversed: Comparison {
        switch self {
        case .less: return .greater
        case .equal: return .equal
        case .greater: return .less
        }
    }

    @inlinable
    public static prefix func ! (value: Comparison) -> Comparison {
        value.reversed
    }
}
