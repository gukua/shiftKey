//
//  ShiftsView.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI

struct ShiftsListView: View {
    @StateObject private var shiftsService = ShiftsServiceImplementation()
    @State private var dimming: Double = 0.5
    @State private var numberOfWeeks = 1

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    List(shiftsService.shifts) { item in
                        NavigationLink(destination: ShiftDetailsView(viewModel: item)) {
                            VStack {
                                HStack {
                                    Text("\(NSLocalizedString("Within distance", comment: "Within distance")): \(item.withinDistance)")
                                        .foregroundColor(.green)
                                    Spacer()
                                    Text(item.facilityType.name)
                                }
                                Spacer()
                                Text("\(NSLocalizedString("Start time", comment: "Start time")): \(item.normalizedStartDateTime)")
                                    .font(.subheadline)
                                Text("\(NSLocalizedString("End time", comment: "End time")): \(item.normalizedEndDateTime)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .accessibilityIdentifier("shiftsList")
                    Button(NSLocalizedString("Load shifts for the next week", comment: "Load shifts for the next week")) {
                        dimming = 0.5
                        Task {
                            await shiftsService.loadMoreContent()
                            dimming = 1
                        }
                    }
                }
                .navigationTitle(NSLocalizedString("Available shifts", comment: "Navigation bar title"))
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .opacity(dimming)
            if shiftsService.isLoadingPage {
                ProgressView(NSLocalizedString("Loading...", comment: "Loading"))
                    .brightness(1)
                    .onAppear {
                        dimming = 0.5
                    }
                    .onDisappear {
                        dimming = 1
                    }
            }
        }
        .alert(isPresented: $shiftsService.isLoadingDataError, content: {
            .init(title: Text(NSLocalizedString("Failed to load data!", comment: "Alert title")), dismissButton: .default(Text(NSLocalizedString("Retry", comment: "Alert button title")), action: {
                Task {
                    await shiftsService.loadMoreContent()
                }
            }))
        })
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsListView()
    }
}
