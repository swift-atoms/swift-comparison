import Comparison
import Testing

@Suite
struct `Comparisons distinguish less equal and greater results` {
    @Test
    func `base comparison exposes its three ordered cases`() {
        #expect(Comparison::Comparison.allCases == [.less, .equal, .greater])
    }
}
