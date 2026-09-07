import Comparison
import Testing

@Suite
struct `Comparison Protocol Tests` {
    @Test
    func `comparable values construct comparisons`() {
        #expect(Comparison::Comparison(1, 2) == .less)
        #expect(Comparison::Comparison(2, 2) == .equal)
    }
}
