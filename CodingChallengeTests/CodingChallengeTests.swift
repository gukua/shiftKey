//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by Brady Miller on 4/7/21.
//

import XCTest
@testable import CodingChallenge

@MainActor
class CodingChallengeTests: XCTestCase {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current
    var sut: DateCreator!

    override func setUp() {
        super.setUp()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        sut = DateCreator()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCurrentDate() {
        let generatedDate = sut.dateForStartOfWeek()

        XCTAssertEqual(dateFormatter.string(from: currentDate), generatedDate)
    }

    func testCurrentWeekEndDate() {
        let generatedDate = sut.dateForNextWeek()
        let endOfWeek = dateFormatter.string(from: calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate)!)

        XCTAssertEqual(endOfWeek, generatedDate)
    }

    func testNextWeekStartDate() {
        _ = sut.dateForStartOfWeek()
        _ = sut.dateForNextWeek()
        let generatedDate = sut.dateForStartOfWeek()
        let endOfWeek = dateFormatter.string(from: calendar.date(byAdding: .day, value: 8, to: currentDate)!)

        XCTAssertEqual(generatedDate, endOfWeek)
    }
}
