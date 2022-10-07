//
//  ShiftsService.swift
//  CodingChallenge
//
//  Created by Adrian Krzyżowski on 02/10/2022.
//

import Foundation
import Combine
import SwiftUI

protocol ShiftsService {
    func loadMoreContent() async
}

@MainActor
final class ShiftsServiceImplementation: ShiftsService, ObservableObject {
    @Published var shifts = [Shift]()
    @Published var isLoadingDataError = false
    @Published var isLoadingPage = false

    private let jsonDecoder = JSONDecoder()
    private let dateCreator = DateCreator()
    private var previousUrl: URL!
    private var shouldFetchForPreviousWeek = false

    init() {
        Task {
            await loadMoreContent()
        }
    }

    func loadMoreContent() async {
        isLoadingPage = true
        var url: URL
        if shouldFetchForPreviousWeek {
            url = previousUrl
        } else {
            url = URL(string: "https://staging-app.shiftkey.com/api/v2/available_shifts?address=Dallas,TX&type=list&start=\(dateCreator.dateForStartOfWeek())&end=\(dateCreator.dateForNextWeek())&radius=7")!
            previousUrl = url
        }
        print(url)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try jsonDecoder.decode(Shifts.self, from: data)
            for index in decodedData.data {
                let set = index.shifts
                shifts.append(contentsOf: set)
            }
            isLoadingPage = false
        } catch {
            isLoadingDataError = true
            shouldFetchForPreviousWeek = true
            isLoadingPage = false
            debugPrint("Error loading data with: \(error)")
        }
    }
}
