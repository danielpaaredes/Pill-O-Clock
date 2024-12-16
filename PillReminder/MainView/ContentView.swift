//
//  ContentView.swift
//  PillReminder
//
//  Created by Daniel Paredes on 05/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var medicinesVM = MedicineViewModel()
    @State private var showModal = false
    let notify = NotificationHandler()
    
    var body: some View {
        NavigationStack {
            ProgressBarView(medicinesVM: medicinesVM)
            Spacer()
            MedicineListView(medicinesVM: medicinesVM)
                .environment(medicinesVM) // Provide the ViewModel to child views
                .navigationTitle("Medications")
                .accessibilityLabel("List of medications")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showModal = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 44, height: 44)
                                    .shadow(radius: 2, x: 0, y: 2)
                                Image(systemName: "plus")
                            }
                        }
                        
                        .accessibilityLabel("Add new medication")
                        .accessibilityHint("Opens a form to add a new medication reminder")

                    }
                }
                .sheet(isPresented: $showModal) {
                    AddNewModalView(medicines: medicinesVM, showModal: $showModal)
                }
                .onAppear {
                    notify.askPermission()
                   
                }
        }
    }
}



#Preview {
    ContentView()
}
