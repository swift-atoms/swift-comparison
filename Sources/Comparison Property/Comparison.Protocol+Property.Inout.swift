public import Property_Inout

extension Comparison::Comparison.`Protocol` where Self: ~Copyable {

    public var compare: Property::Property<Comparison::Comparison.Compare, Self>.Inout {
        mutating _read {
            yield Property::Property<Comparison::Comparison.Compare, Self>.Inout(&self)
        }
    }
}

extension Comparison::Comparison.`Protocol` where Self: Copyable {

    public var clamp: Property::Property<Comparison::Comparison.Clamp, Self>.Inout {
        mutating _read {
            yield Property::Property<Comparison::Comparison.Clamp, Self>.Inout(&self)
        }
    }
}
