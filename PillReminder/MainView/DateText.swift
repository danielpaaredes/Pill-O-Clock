//
//  DateText.swift
//  PillReminder
//
//  Created by Daniel Paredes on 07/12/24.
//

import SwiftUI

struct DateText: View {
    
    @ObservedObject var medicinesVM: MedicineViewModel
    
    @State var currentDate = Date()
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d yyyy"
        return formatter
    }()
    
    var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    var body: some View {
        
        VStack {
            Image(systemName: "pill")
            
            Text("\(medicinesVM.medicines.filter { $0.isTaken }.count)/\(medicinesVM.medicines.count)")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(dayFormatter.string(from: currentDate))
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Text(dateFormatter.string(from: currentDate))
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
        }
            .onAppear() {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){
                    _ in currentDate = Date()
                }
        }
                .padding()
        }
}

/*#Preview {
    DateText()
}*/
