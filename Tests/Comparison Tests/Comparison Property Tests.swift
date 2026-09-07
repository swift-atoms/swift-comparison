import Comparison
import Testing

@Suite
struct `Comparable values expose a comparison accessor` {
    @Test
    func `comparable values expose the comparison property`() {
        var value = 1
        #expect(value.compare.to(2) == .less)
    }
}
