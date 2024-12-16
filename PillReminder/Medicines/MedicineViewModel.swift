//
//  MedicineViewModel.swift
//  PillReminder
//
//  Created by Daniel Paredes on 09/12/24.
//

import Foundation

class MedicineViewModel: ObservableObject, Observable {
    @Published var medicines: [Medicine] = []
    
    var progress: Float {
            guard !medicines.isEmpty else { return 0.0 }
            let takenCount = medicines.filter { $0.isTaken }.count
            return Float(takenCount) / Float(medicines.count)
        }

    func removedExpired(){
        let today = Date()
        let calendar = Calendar.current
        
        medicines.removeAll { medicine in
            let isSameday = calendar.isDate(medicine.selectedEndDate, inSameDayAs: today)
            
            return medicine.selectedEndDate < today || (isSameday && medicine.selectedEndDate < today)
            medicine.selectedEndDate < today
            }
    }
    
    func add(_ medicine: Medicine){
        self.medicines.append(medicine)
    }
    
    func delete(at offsets: IndexSet)
    {
        self.medicines.remove(atOffsets: offsets)
    }
}
