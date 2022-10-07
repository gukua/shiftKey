//
//  Shifts.swift
//  CodingChallenge
//
//  Created by Adrian Krzyżowski on 02/10/2022.
//

import Foundation

struct Shifts: Decodable {
    let data: [ShiftSet]
}

struct ShiftSet: Decodable {
    let date: String
    let shifts: [Shift]
}

struct Shift: Identifiable, Decodable {
    let shiftId: Int
    let timezone: String
    let shiftKind: String
    let withinDistance: Int
    let normalizedStartDateTime: String
    let normalizedEndDateTime: String
    let facilityType: FacilityType
    let skill: Skill
    let localizedSpecialty: LocalizedSpecialty
}

struct FacilityType: Decodable {
    let id: Int
    let name: String
    let color: String
}

struct Skill: Decodable {
    let id: Int
    let name: String
    let color: String
}

struct LocalizedSpecialty: Decodable {
    let id: Int
    let name: String
    let abbreviation: String
    let specialty: Specialty
}

struct Specialty: Decodable {
    let id: Int
    let name: String
    let color: String
    let abbreviation: String
}

extension Shift {
    var id: UUID { UUID() }
}
