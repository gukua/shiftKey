//
//  CodingChallengeUITests.swift
//  CodingChallengeUITests
//
//  Created by Brady Miller on 4/7/21.
//

import XCTest

class CodingChallengeUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func testShiftsListAppear() {
        shiftsList(app: app).navigationBarTitle().waitForElementToAppear()
    }

    func testShiftDetailsAppear() {
        shiftsList(app: app) {
            $0.navigationBarTitle().waitForElementToAppear()
            $0.shiftsListCell {
                $0.waitForElementToAppear()
                $0.tap()
            }
            $0.detailsIdLabel().waitForElementToAppear()
        }
    }
}
