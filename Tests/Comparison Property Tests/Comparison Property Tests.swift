import Comparison_Property
import Testing

@Suite
struct `Comparison Property Tests` {
    @Test
    func `comparable values expose the comparison property`() {
        var value = 1
        #expect(value.compare.to(2) == .less)
    }
}
