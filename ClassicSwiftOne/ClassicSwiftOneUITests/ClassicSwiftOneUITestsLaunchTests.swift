//
//  ClassicSwiftOneUITestsLaunchTests.swift
//  ClassicSwiftOneUITests
//
//  Created by Hagau Ioan on 29.05.2024.
//

import XCTest

final class ClassicSwiftOneUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        
        /*
         * Attachments have the default lifetime of .deleteOnSuccess, which means they are deleted when
         * their test passes. This ensures attachments are only kept when test fails. To override this
         * behavior, change the value of the `lifetime` property to .keepAlways before adding it to an activity.
         */
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
