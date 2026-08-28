public import Property

extension Property.Inout where Base: Swift.Comparable, Tag == Comparison.Clamp {

    @_disfavoredOverload
    @inlinable
    public func between(_ lower: Base, and upper: Base) -> Base {
        let value = base.value
        if value < lower {
            return lower
        } else if value > upper {
            return upper
        } else {
            return value
        }
    }

    @_disfavoredOverload
    @inlinable
    public func above(_ minimum: Base) -> Base {
        let value = base.value
        return value < minimum ? minimum : value
    }

    @_disfavoredOverload
    @inlinable
    public func below(_ maximum: Base) -> Base {
        let value = base.value
        return value > maximum ? maximum : value
    }
}

extension Swift.Comparable where Self: Copyable {

    @_disfavoredOverload
    public var clamp: Property<Comparison.Clamp, Self>.Inout {
        mutating _read {
            yield Property<Comparison.Clamp, Self>.Inout(&self)
        }
    }
}
