//
//  MedicineListView.swift
//  PillReminder
//
//  Created by Daniel Paredes on 09/12/24.
//

import SwiftUI

struct MedicineListView: View {
    @ObservedObject var medicinesVM: MedicineViewModel // Use the shared ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if medicinesVM.medicines.isEmpty {
                    Text("No medicines added")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                } else {
                    medicineList
                }
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Medications")
        .background(Color.white)
    }
    
    // MARK: Views
    
    var medicineList: some View {
        ForEach($medicinesVM.medicines) { $medicine in
            NavigationLink(destination: MedicineDetailView(currentMedicine: medicine)){
                MedicineView(medicine: $medicine)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.1)
                            .stroke(.black, lineWidth: 0.2)
                    }
                    .background(Color.white)
                    .cornerRadius(8)
            }

        }
        .onDelete(perform: medicinesVM.delete)
    }
    
}


//#Preview {
//    MedicineListView(medicinesVM: <#MedicineViewModel#>)
//        .environmentObject(MedicineViewModel()) // Provide the ViewModel for preview
//}
