//
//  MedicineModel.swift
//  PillReminder
//
//  Created by Daniel Paredes on 07/12/24.
//

import Foundation

struct Medicine: Identifiable {
    let id = UUID()
    var name: String
    var time: Date
    var isTaken: Bool = false
    var selectedEndDate: Date
    var selectedStartDate: Date
}
