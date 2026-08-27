public import Comparison

extension Comparison: CaseIterable {

    public static var allCases: [Comparison] {
        [.less, .equal, .greater]
    }
}
