//
//  MedicineView.swift
//  PillReminder
//
//  Created by Daniel Paredes on 10/12/24.
//
import SwiftUI

struct MedicineView: View {
    @Binding var medicine: Medicine
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(medicine.name)
                    .font(.headline)
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text(medicine.time, style: .time)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
            Spacer()
            Toggle("", isOn: $medicine.isTaken)
                .labelsHidden()
                .tint(.blue)
        }
    }
    
}
