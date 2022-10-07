//
//  DateCreator.swift
//  CodingChallenge
//
//  Created by Adrian Krzyżowski on 06/10/2022.
//

import Foundation

final class DateCreator {
    private var startOfTheWeek = Date()
    private var endOfTheWeek: Date?
    private var wasInitialDate = false
    private let calendar = Calendar.current
    private var formatter = DateFormatter()

    init() {
        formatter.dateFormat = "yyyy-MM-dd"
    }

    func dateForStartOfWeek() -> String {
        if let endOfTheWeek, wasInitialDate {
            startOfTheWeek = calendar.date(byAdding: .day, value: 1, to: endOfTheWeek)!
        }
        wasInitialDate = true
        return formatter.string(from: startOfTheWeek)
    }

    func dateForNextWeek() -> String {
        endOfTheWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfTheWeek)
        return formatter.string(from: endOfTheWeek!)
    }
}

