import XCTest

import CardanoTests

var tests = [XCTestCaseEntry]()
tests += CardanoTests.allTests()
XCTMain(tests)
