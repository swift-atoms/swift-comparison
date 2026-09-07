extension Comparison::Comparison {

    @inlinable
    @_disfavoredOverload
    public init<T: Swift.Comparable & ~Copyable>(
        comparing lhs: borrowing T,
        to rhs: borrowing T
    ) {
        if lhs < rhs {
            self = .less
        } else if lhs > rhs {
            self = .greater
        } else {
            self = .equal
        }
    }
}
