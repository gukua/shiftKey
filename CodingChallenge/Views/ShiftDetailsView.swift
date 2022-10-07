//
//  ShiftDetailsView.swift
//  CodingChallenge
//
//  Created by Adrian Krzyżowski on 02/10/2022.
//

import SwiftUI

struct ShiftDetailsView: View {
    let viewModel: Shift

    var body: some View {
        VStack {
            VStack {
                Text("ID: \(viewModel.shiftId)")
                    .foregroundColor(.red)
                    .accessibilityIdentifier("detailsIdLabel")
                HStack {
                    Text("\(NSLocalizedString("Timezone", comment: "Timezone")): ")
                    Text(viewModel.timezone)
                        .font(.largeTitle)
                        .bold()
                }
                VStack {
                    Text(viewModel.shiftKind)
                        .foregroundColor(.gray)
                    .bold()
                    HStack {
                        Text("\(NSLocalizedString("From", comment: "From")): \(viewModel.normalizedStartDateTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(NSLocalizedString("to", comment: "to")): \(viewModel.normalizedEndDateTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top)
                VStack {
                    Text("\(NSLocalizedString("Skill", comment: "Skill")):")
                    Text(viewModel.skill.name)
                        .background(Color(.init(hex: viewModel.skill.color)))
                        .font(.title)
                }
                .padding(.vertical)
                VStack {
                    Text("\(NSLocalizedString("Specialty", comment: "Specialty")):")
                    Text(viewModel.localizedSpecialty.name)
                        .background(Color(.init(hex: viewModel.localizedSpecialty.specialty.color)))
                        .font(.title)
                    Text(viewModel.localizedSpecialty.abbreviation)
                }
            }
        }
    }
}

struct ShiftDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftDetailsView(viewModel: .init(shiftId: 1, timezone: "Timezone", shiftKind: "Kind", withinDistance: 150, normalizedStartDateTime: "12:00 2222-12-12", normalizedEndDateTime: "13:00 2222-12-12", facilityType: .init(id: 1, name: "Name", color: "#ffe70d"), skill: .init(id: 1, name: "Skill", color: "#ffe70d"), localizedSpecialty: .init(id: 1, name: "Specialty", abbreviation: "Abbr", specialty: .init(id: 1, name: "Specialty name", color: "#007AFF", abbreviation: "abbr/abbr"))))
    }
}
