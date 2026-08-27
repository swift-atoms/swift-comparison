import Testing

@testable import Comparison
import Comparison_Standard_Library_Integration

@Suite
struct `Comparison Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension `Comparison Tests`.Unit {
    @Suite struct Cases {}
    @Suite struct Reversal {}
    @Suite struct Chaining {}
    @Suite struct `Boolean Properties` {}
    @Suite struct `Swift.Comparable Construction` {}
    @Suite struct `Protocol Conformances` {}
    @Suite struct `Comparison.Protocol Construction` {}
    @Suite struct `Lexicographic Comparison` {}
}

private struct Token: ~Copyable, Comparison.`Protocol` {
    let id: Int
}

extension Token {
    static func < (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.id < rhs.id
    }

    static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.id == rhs.id
    }
}

private actor Holder {
    var value: Comparison = .equal
}

extension Holder {
    func set(_ v: Comparison) { value = v }
    func get() -> Comparison { value }
}

private struct Person: Equatable {
    let name: String
    let age: Int
    let id: Int
}

private func compare(_ lhs: Person, _ rhs: Person) -> Comparison {
    Comparison(comparing: lhs.name, to: rhs.name)
        .then(Comparison(comparing: lhs.age, to: rhs.age))
        .then(Comparison(comparing: lhs.id, to: rhs.id))
}

extension `Comparison Tests`.Unit.Cases {
    @Test
    func `All cases exist`() {
        let cases = Comparison.allCases
        #expect(cases.count == 3)
        #expect(cases.contains(.less))
        #expect(cases.contains(.equal))
        #expect(cases.contains(.greater))
    }
}

extension `Comparison Tests`.Unit.Reversal {
    @Test
    func `Reversal mapping`() {
        #expect(Comparison.less.reversed == .greater)
        #expect(Comparison.equal.reversed == .equal)
        #expect(Comparison.greater.reversed == .less)
    }

    @Test
    func `Reversal is involution: rev(rev(x)) = x`() {
        for value in Comparison.allCases {
            #expect(value.reversed.reversed == value)
        }
    }

    @Test
    func `Prefix ! operator`() {
        #expect(!Comparison.less == .greater)
        #expect(!Comparison.equal == .equal)
        #expect(!Comparison.greater == .less)
    }

    @Test
    func `Prefix ! is equivalent to reversed`() {
        for value in Comparison.allCases {
            #expect(!value == value.reversed)
        }
    }
}

extension `Comparison Tests`.Unit.Chaining {
    @Test
    func `Left identity: equal.then(x) = x`() {
        for value in Comparison.allCases {
            #expect(Comparison.equal.then(value) == value)
        }
    }

    @Test
    func `Right identity: x.then(equal) = x`() {
        for value in Comparison.allCases {
            #expect(value.then(.equal) == value)
        }
    }

    @Test
    func `Associativity: (x.then(y)).then(z) = x.then(y.then(z))`() {
        let cases = Comparison.allCases
        for x in cases {
            for y in cases {
                for z in cases {
                    let left = x.then(y).then(z)
                    let right = x.then(y.then(z))
                    #expect(left == right)
                }
            }
        }
    }

    @Test
    func `Short-circuit behavior`() {
        #expect(Comparison.less.then(.greater) == .less)
        #expect(Comparison.greater.then(.less) == .greater)
        #expect(Comparison.equal.then(.less) == .less)
        #expect(Comparison.equal.then(.greater) == .greater)
    }

    @Test
    func `Lazy chaining with then(with:)`() {
        var evaluationCount = 0

        let lazyValue: () -> Comparison = {
            evaluationCount += 1
            return .greater
        }

        _ = Comparison.less.then(with: lazyValue)
        #expect(evaluationCount == 0)

        _ = Comparison.greater.then(with: lazyValue)
        #expect(evaluationCount == 0)

        let result = Comparison.equal.then(with: lazyValue)
        #expect(evaluationCount == 1)
        #expect(result == .greater)
    }
}

extension `Comparison Tests`.Unit.`Boolean Properties` {
    @Test
    func `isLess`() {
        #expect(Comparison.less.isLess == true)
        #expect(Comparison.equal.isLess == false)
        #expect(Comparison.greater.isLess == false)
    }

    @Test
    func `isEqual`() {
        #expect(Comparison.less.isEqual == false)
        #expect(Comparison.equal.isEqual == true)
        #expect(Comparison.greater.isEqual == false)
    }

    @Test
    func `isGreater`() {
        #expect(Comparison.less.isGreater == false)
        #expect(Comparison.equal.isGreater == false)
        #expect(Comparison.greater.isGreater == true)
    }

    @Test
    func `isLessOrEqual`() {
        #expect(Comparison.less.isLessOrEqual == true)
        #expect(Comparison.equal.isLessOrEqual == true)
        #expect(Comparison.greater.isLessOrEqual == false)
    }

    @Test
    func `isGreaterOrEqual`() {
        #expect(Comparison.less.isGreaterOrEqual == false)
        #expect(Comparison.equal.isGreaterOrEqual == true)
        #expect(Comparison.greater.isGreaterOrEqual == true)
    }
}

extension `Comparison Tests`.Unit.`Swift.Comparable Construction` {
    @Test
    func `Int comparison`() {
        #expect(Comparison(comparing: 1, to: 2) == .less)
        #expect(Comparison(comparing: 2, to: 2) == .equal)
        #expect(Comparison(comparing: 3, to: 2) == .greater)
    }

    @Test
    func `String comparison`() {
        #expect(Comparison(comparing: "apple", to: "banana") == .less)
        #expect(Comparison(comparing: "hello", to: "hello") == .equal)
        #expect(Comparison(comparing: "zebra", to: "apple") == .greater)
    }

    @Test
    func `Double comparison`() {
        #expect(Comparison(comparing: 1.5, to: 2.5) == .less)
        #expect(Comparison(comparing: 2.5, to: 2.5) == .equal)
        #expect(Comparison(comparing: 3.5, to: 2.5) == .greater)
    }
}

extension `Comparison Tests`.Unit.`Protocol Conformances` {
    @Test
    func `Hashable - can be used in Set`() {
        let set: Set<Comparison> = [.less, .equal, .greater]
        #expect(set.count == 3)
    }

    @Test
    func `Hashable - can be used as dictionary key`() {
        let dict: [Comparison: String] = [
            .less: "less",
            .equal: "equal",
            .greater: "greater",
        ]
        #expect(dict[.less] == "less")
        #expect(dict[.equal] == "equal")
        #expect(dict[.greater] == "greater")
    }

    @Test
    func `Sendable - can pass to actor`() async {
        let holder = Holder()
        await holder.set(.less)
        let result = await holder.get()
        #expect(result == .less)
    }
}

extension `Comparison Tests`.Unit.`Comparison.Protocol Construction` {
    @Test
    func `~Copyable type comparison via Result`() {
        let a = Token(id: 1)
        let b = Token(id: 2)
        let c = Token(id: 1)

        #expect(Comparison(a, b) == .less)
        #expect(Comparison(b, a) == .greater)
        #expect(Comparison(a, c) == .equal)
    }

    @Test
    func `~Copyable operators: less than`() {
        let a = Token(id: 5)
        let b = Token(id: 10)
        let result: Bool = a < b
        #expect(result == true)
    }

    @Test
    func `~Copyable operators: greater than`() {
        let a = Token(id: 10)
        let b = Token(id: 5)
        let result: Bool = a > b
        #expect(result == true)
    }

    @Test
    func `~Copyable operators: less than or equal`() {
        let a = Token(id: 5)
        let b = Token(id: 5)
        let result: Bool = a <= b
        #expect(result == true)
    }

    @Test
    func `~Copyable operators: greater than or equal`() {
        let a = Token(id: 5)
        let b = Token(id: 5)
        let result: Bool = a >= b
        #expect(result == true)
    }

    @Test
    func `~Copyable operators: equal`() {
        let a = Token(id: 5)
        let b = Token(id: 5)
        let result: Bool = a == b
        #expect(result == true)
    }
}

extension `Comparison Tests`.Unit.`Lexicographic Comparison` {
    @Test
    func `Multi-field comparison`() {
        let alice1 = Person(name: "Alice", age: 30, id: 1)
        let alice2 = Person(name: "Alice", age: 30, id: 2)
        let alice3 = Person(name: "Alice", age: 25, id: 1)
        let bob = Person(name: "Bob", age: 30, id: 1)

        #expect(compare(alice1, alice2) == .less)

        #expect(compare(alice1, alice3) == .greater)

        #expect(compare(alice1, bob) == .less)

        #expect(compare(alice1, alice1) == .equal)
    }
}
