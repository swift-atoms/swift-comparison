public import Property

extension Property::Property.Inout where Base: Swift.Comparable & ~Copyable, Tag == Comparison::Comparison.Compare {

    @_disfavoredOverload
    @inlinable
    public func to(_ other: borrowing Base) -> Comparison::Comparison {
        Comparison::Comparison(comparing: base.value, to: other)
    }

    @_disfavoredOverload
    @inlinable
    public func isLess(than other: borrowing Base) -> Bool {
        base.value < other
    }

    @_disfavoredOverload
    @inlinable
    public func isGreater(than other: borrowing Base) -> Bool {
        base.value > other
    }

    @_disfavoredOverload
    @inlinable
    public func isEqual(to other: borrowing Base) -> Bool {
        base.value == other
    }

    @_disfavoredOverload
    @inlinable
    public func isLessOrEqual(to other: borrowing Base) -> Bool {
        base.value <= other
    }

    @_disfavoredOverload
    @inlinable
    public func isGreaterOrEqual(to other: borrowing Base) -> Bool {
        base.value >= other
    }
}

extension Swift.Comparable where Self: Copyable {

    @_disfavoredOverload
    public var compare: Property::Property<Comparison::Comparison.Compare, Self>.Inout {
        mutating _read {
            yield Property::Property<Comparison::Comparison.Compare, Self>.Inout(&self)
        }
    }
}
