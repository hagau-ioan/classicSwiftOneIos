//
//  UnitTests.swift
//  UnitTests
//
//  Created by Hagau Ioan on 27.05.2024.
//

import XCTest
/*
 * To run from console:
 * xcodebuild test -workspace 'ClassicSwiftOne.xcworkspace' -scheme 'ClassicSwiftOne' -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0.2'
 */
final class ExampleUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertEqual(1, 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
//            for i in 1 ..< 100000 {
//                print(i)
//            }
            // Put the code you want to measure the time of here.
        }
    }

}