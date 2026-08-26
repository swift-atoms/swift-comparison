public import Property

extension Property.Inout
where Base: Comparison.`Protocol` & Copyable, Tag == Comparison.Clamp {

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

    @inlinable
    public func above(_ minimum: Base) -> Base {
        let value = base.value
        return value < minimum ? minimum : value
    }

    @inlinable
    public func below(_ maximum: Base) -> Base {
        let value = base.value
        return value > maximum ? maximum : value
    }
}
