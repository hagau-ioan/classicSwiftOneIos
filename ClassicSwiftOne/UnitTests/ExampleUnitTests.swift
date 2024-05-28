//
//  UnitTests.swift
//  UnitTests
//
//  Created by Hagau Ioan on 27.05.2024.
//

import XCTest
@testable import ClassicSwiftOne

/*
 * To run from console:
 * xcodebuild test -workspace 'ClassicSwiftOne.xcworkspace' -scheme 'ClassicSwiftOne' -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0.2'
 *
 * In ios there is no concept of mocking data.
 * We need to provide all the arguments as injected (using a DI lib or factory pattern)
 * Usualy to have a nice flow unit testing we need to base the testing over the return result of the method or based on a member variable
 * from tested class which will provide us the value (this is for async methods - using tasks)
 */
final class ExampleUnitTests: XCTestCase {

    var viewModel: MainViewModel? = nil
    
    override func setUpWithError() throws {
        viewModel = MainViewModel(
            postsUseCase : nil,
            imagesUseCase:nil,
            settings : nil,
            keyChain : nil,
            userUsercase : nil
        )    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testExample() async throws {
        let expectedValue = 2
        let task = await viewModel?.methodForTestTask(value: expectedValue)
        let value = try await task?.value
        XCTAssertEqual(expectedValue, value)
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
