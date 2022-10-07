//
//  ShiftsListRobot.swift
//  CodingChallengeUITests
//
//  Created by Adrian Krzyżowski on 06/10/2022.
//

import Foundation
import XCTest

@discardableResult
func shiftsList(app: XCUIApplication, closure: (ShiftScreenRobot) -> Void = { _ in }) -> ShiftScreenRobot {
    let robot = ShiftScreenRobot(app: app)
    closure(robot)
    return robot
}

class ShiftScreenRobot {
    let app: XCUIApplication
    init(app: XCUIApplication) {
        self.app = app
    }

    @discardableResult
    func navigationBarTitle(_ closure: (XCUIElement) -> Void = { _ in }) -> XCUIElement {
        with(app.navigationBars["Available shifts"].staticTexts["Available shifts"], closure)
    }

    @discardableResult
    func shiftsListCell(_ closure: (XCUIElement) -> Void = { _ in }) -> XCUIElement {
        with(app.collectionViews["shiftsList"].cells.element(boundBy: 1), closure)
    }

    @discardableResult
    func detailsIdLabel(_ closure: (XCUIElement) -> Void = { _ in }) -> XCUIElement {
        with(app.staticTexts["detailsIdLabel"], closure)
    }
}
