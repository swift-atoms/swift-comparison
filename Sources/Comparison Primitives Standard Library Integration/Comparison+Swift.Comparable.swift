// Comparison+Swift.Comparable.swift
// Comparison initializer for Swift.Comparable types.

extension Comparison {
    /// Creates a comparison result from two `Swift.Comparable` values.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
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
