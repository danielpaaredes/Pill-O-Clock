//
//  AddNewModalView.swift
//  PillReminder
//
//  Created by Daniel Paredes on 05/12/24.
//

import SwiftUI

struct AddNewModalView: View {    
    @State var name = ""
    @State var selectTime = Date()
    @State var selectedStartDate = Date()
    @State var selectedEndDate: Date = Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date()
    
    private var totalDays: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day], from: selectedStartDate, to: selectedEndDate)
        return components.day ?? 0
    }
    @ObservedObject var medicines: MedicineViewModel // Use the shared ViewModel
    let notify = NotificationHandler()
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Name"){
                    TextField("Add name", text: $name)
                }
                Section("At what time do you have to take it?"){
                    DatePicker("Select time", selection: $selectTime, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                }
                Section("Start Date"){
                    DatePicker("Select start date", selection: $selectedStartDate, displayedComponents: [.date])
                    
                }
                Section("End Date"){
                    DatePicker("Select end date", selection: $selectedEndDate, displayedComponents: [.date])
                }
                Section("Total days"){
                    Text("\(totalDays) days")
                }
            }
            .navigationTitle("New Reminder")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showModal = false
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button{
                        addNewMedicineAndNotifications()
                        //medicines.append(newMedicine)
                    } label: {
                        Text("Add")
                    }
                }
                }
            }
        }
    private func addNewMedicineAndNotifications(){
        guard !name.isEmpty else { return }
        
        let newMedicine = Medicine(name: name, time: selectTime, isTaken: false, selectedEndDate: selectedEndDate, selectedStartDate: selectedStartDate)
        medicines.add(newMedicine)
        
        var currentDay = selectedStartDate
        while currentDay <= selectedEndDate {
            if let notificationDate = combine(date: currentDay, time: selectTime){
                notify.sendNotification(
                    date: Date(),
                    type: "time",
                    title: "Pill time",
                    body: "Its time to take your medicine: \(name)"
                )
            }
            currentDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDay) ?? currentDay
        }
        showModal.toggle()
    }
    private func combine(date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        return calendar.date(from: combinedComponents)

    }

}

            
            
