public import Property_Primitives

extension Comparison.`Protocol` where Self: ~Copyable {

    public var compare: Property<Comparison.Compare, Self>.Inout {
        mutating _read {
            yield Property<Comparison.Compare, Self>.Inout(&self)
        }
    }
}

extension Comparison.`Protocol` where Self: Copyable {

    public var clamp: Property<Comparison.Clamp, Self>.Inout {
        mutating _read {
            yield Property<Comparison.Clamp, Self>.Inout(&self)
        }
    }
}
