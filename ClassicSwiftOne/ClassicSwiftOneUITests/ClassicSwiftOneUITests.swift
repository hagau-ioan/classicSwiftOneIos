//
//  ClassicSwiftOneUITests.swift
//  ClassicSwiftOneUITests
//
//  Created by Hagau Ioan on 29.05.2024.
//

import XCTest
/*
 * Reference for testing UI: https://semaphoreci.com/blog/ui-testing-swift
 * https://ahmadgsufi.medium.com/user-interface-testing-for-ios-apps-a-comprehensive-guide-a2e933d83be0
 * To filter out some logic during e2e tests we can use something like this:
 * let isUnitTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
 */
final class ClassicSwiftOneUITests: XCTestCase {
    
    var app: XCUIApplication?
    
    override func setUpWithError() throws {
        continueAfterFailure = true
        XCUIDevice.shared.orientation = .portrait
        app = XCUIApplication()
        app?.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        
        let tablesQuery = app?.tables
        // let count = tablesQuery.element(boundBy: 0).cells.count
        let cell = tablesQuery?.element(boundBy: 0).cells.element(boundBy: 2)
        cell?.tap() // Click the cell and go to details screen
        
        let _ = app?.navigationBars.buttons["Home Screen"].waitForExistence(timeout: 1)// wait for the Home Screen button
        
        XCTAssert(app?.navigationBars.buttons["Home Screen"].exists ?? false) // is the button visible
        
        app?.navigationBars.buttons["Home Screen"].tap()  // Go back to the previous screen
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
