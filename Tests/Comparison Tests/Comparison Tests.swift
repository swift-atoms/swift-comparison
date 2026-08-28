import Comparison
import Testing

@Suite
struct `Comparison Tests` {
    @Test
    func `base comparison exposes its three ordered cases`() {
        #expect(Comparison::Comparison.allCases == [.less, .equal, .greater])
    }
}
