extension Comparison::Comparison {

    @inlinable

    public init<T: Comparison::Comparison.`Protocol` & ~Copyable>(_ lhs: borrowing T, _ rhs: borrowing T) {
        if lhs < rhs {
            self = .less
        } else if lhs > rhs {
            self = .greater
        } else {
            self = .equal
        }
    }
}
