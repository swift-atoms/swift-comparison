public import Property_Inout

extension Property::Property.Inout
where Base: Comparison::Comparison.`Protocol` & ~Copyable, Tag == Comparison::Comparison.Compare {

    @inlinable
    public func to(_ other: borrowing Base) -> Comparison::Comparison {
        if base.value < other {
            return .less
        } else if base.value == other {
            return .equal
        } else {
            return .greater
        }
    }

    @inlinable
    public func isLess(than other: borrowing Base) -> Bool {
        base.value < other
    }

    @inlinable
    public func isGreater(than other: borrowing Base) -> Bool {
        base.value > other
    }

    @inlinable
    public func isEqual(to other: borrowing Base) -> Bool {
        base.value == other
    }

    @inlinable
    public func isLessOrEqual(to other: borrowing Base) -> Bool {
        base.value <= other
    }

    @inlinable
    public func isGreaterOrEqual(to other: borrowing Base) -> Bool {
        base.value >= other
    }
}
