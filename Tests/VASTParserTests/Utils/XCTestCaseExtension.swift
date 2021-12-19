import XCTest

extension XCTestCase {
    var defaultTimeout: TimeInterval { 0.1 }

    func wait(forExpectation expectation: XCTestExpectation) {
        wait(for: [expectation], timeout: defaultTimeout)
    }

    func wait(for expectations: [XCTestExpectation]) {
        wait(for: expectations, timeout: defaultTimeout)
    }

    func wait(for expectations: [XCTestExpectation], enforceOrder: Bool) {
        wait(for: expectations, enforceOrder: enforceOrder)
    }
}
