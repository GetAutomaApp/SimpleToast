import XCTest

#if !canImport(ObjectiveC)
/// all tests
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SimpleToastTests.allTests),
    ]
}
#endif
