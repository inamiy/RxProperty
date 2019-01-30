import XCTest
import RxSwift
import RxCocoa
@testable import RxProperty

final class RxPropertyTests: XCTestCase {

    // MARK: - initWithBehaviorRelay

    func test_initWithBehaviorRelay_value() {

        let relay = BehaviorRelay<Int>(value: 0)
        let property = Property<Int>(relay)

        XCTAssertEqual(property.value, 0)

        relay.accept(1)
        XCTAssertEqual(property.value, 1)

        relay.accept(2)
        XCTAssertEqual(property.value, 2)

    }

    func test_initWithBehaviorRelay_asObservable() {

        let relay = BehaviorRelay<Int>(value: 0)
        var property: Property<Int>! = .init(relay)

        var events = [Event<Int>]()

        // `.asObservable()` test
        _ = property.asObservable().subscribe { event in
            events.append(event)
        }

        XCTAssertEqual(events, [.next(0)],
                       "should observe initial value")

        relay.accept(1)
        XCTAssertEqual(events, [.next(0), .next(1)])

        relay.accept(2)
        XCTAssertEqual(events, [.next(0), .next(1), .next(2)])

        property = nil
        XCTAssertEqual(events, [.next(0), .next(1), .next(2)],
                       "`.completed` should NOT be observed when `property` is deallocated")

        relay.accept(3)
        XCTAssertEqual(events, [.next(0), .next(1), .next(2), .next(3)],
                       "`property`'s observable should still be alive even when `property` is deallocated.")

    }

    func test_initWithBehaviorRelay_changed() {

        let relay = BehaviorRelay<Int>(value: 0)
        var property: Property<Int>! = .init(relay)

        var events = [Event<Int>]()

        // `.changed` test
        _ = property.changed.subscribe { event in
            events.append(event)
        }

        XCTAssertEqual(events, [Event<Int>](),
                       "should NOT observe initial value")

        relay.accept(1)
        XCTAssertEqual(events, [.next(1)])

        relay.accept(2)
        XCTAssertEqual(events, [.next(1), .next(2)])

        property = nil
        XCTAssertEqual(events, [.next(1), .next(2)],
                       "`.completed` should NOT be observed when `property` is deallocated")

        relay.accept(3)
        XCTAssertEqual(events, [.next(1), .next(2), .next(3)],
                       "`property`'s observable should still be alive even when `property` is deallocated.")

    }

    // MARK: - initWithUnsafe

    func test_initWithUnsafe_value() {

        let relay = BehaviorRelay<Int>(value: 0)
        let property = Property<Int>(unsafeObservable: relay.asObservable())

        XCTAssertEqual(property.value, 0)

        relay.accept(1)
        XCTAssertEqual(property.value, 1)

        relay.accept(2)
        XCTAssertEqual(property.value, 2)

    }

    func test_initWithUnsafe_asObservable() {

        let relay = BehaviorRelay<Int>(value: 0)
        var property: Property<Int>! = .init(unsafeObservable: relay.asObservable())

        var events = [Event<Int>]()

        // `.asObservable()` test
        _ = property.asObservable().subscribe { event in
            events.append(event)
        }

        XCTAssertEqual(events, [.next(0)],
                       "should observe initial value")

        relay.accept(1)
        XCTAssertEqual(events, [.next(0), .next(1)])

        relay.accept(2)
        XCTAssertEqual(events, [.next(0), .next(1), .next(2)])

        property = nil
        XCTAssertEqual(events, [.next(0), .next(1), .next(2)],
                       "`.completed` should NOT be observed when `property` is deallocated")

        relay.accept(3)
        XCTAssertEqual(events, [.next(0), .next(1), .next(2), .next(3)],
                       "`property`'s observable should still be alive even when `property` is deallocated.")

    }

    func test_initWithUnsafe_changed() {

        let relay = BehaviorRelay<Int>(value: 0)
        var property: Property<Int>! = .init(unsafeObservable: relay.asObservable())

        var events = [Event<Int>]()

        // `.changed` test
        _ = property.changed.subscribe { event in
            events.append(event)
        }

        XCTAssertEqual(events, [Event<Int>](),
                       "should NOT observe initial value")

        relay.accept(1)
        XCTAssertEqual(events, [.next(1)])

        relay.accept(2)
        XCTAssertEqual(events, [.next(1), .next(2)])

        property = nil
        XCTAssertEqual(events, [.next(1), .next(2)])

        relay.accept(3)
        XCTAssertEqual(events, [.next(1), .next(2), .next(3)],
                       "`property`'s observable should still be alive even when `property` is deallocated.")

    }

}

// MARK: RxSwift.Event + Equatable

extension RxSwift.Event: Equatable where Element: Equatable {

    /// - Warning: Dirty implementation.
    public static func == (l: RxSwift.Event<Element>, r: RxSwift.Event<Element>) -> Bool {
        switch (l, r) {
        case let (.next(l), .next(r)):
            return l == r
        case let (.error(l), .error(r)):
            return "\(l)" == "\(r)" // dirty
        case (.completed, .completed):
            return true
        default:
            return false
        }
    }

}
