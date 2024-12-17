import SwiftUI

extension DateFormatter {
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}

import SwiftUI

struct MedicineDetailView: View {
    @Binding var currentMedicine: Medicine
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ToggleOnlyCard(text: "is Taken?", isOn: $currentMedicine.isTaken)
                
                MedicineDetailCard(title: "Time", value: currentMedicine.time, formatter: DateFormatter.shortTime, iconName: "clock")
                MedicineDetailCard(title: "Start Date", value: currentMedicine.selectedStartDate, formatter: DateFormatter.shortDate, iconName: "calendar.badge.plus")
                MedicineDetailCard(title: "Finish Date", value: currentMedicine.selectedEndDate, formatter: DateFormatter.shortDate, iconName: "calendar.badge.minus")
                
                
                
            }
            .navigationTitle(currentMedicine.name)
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
            .cornerRadius(15)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }
}

// MARK: - Reusable Card Component
struct MedicineDetailCard: View {
    let title: String
    let value: Date
    let formatter: DateFormatter
    let iconName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
            
            
            HStack (spacing: 15){
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .stroke(Color.black, lineWidth: 0.1)
                        .frame(width: 40, height: 40)
                       
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                    
                    Image(systemName: iconName)
                        .font(.headline)
                        .foregroundColor(Color.blue)
                   
                    
                    }
                .accessibilityHidden(true)
        
                VStack (alignment: .leading, spacing: 2){
                    Text(title)
                        .font(.caption)
                        .foregroundColor(Color.black.opacity(0.5))

                                        
                    Text("\(value, formatter: formatter)")
                        .font(.footnote)
                        .fontWeight(.semibold)
                                            
                }
               
                   
            }
            .padding()
        }
        
    }
}


struct ToggleOnlyCard: View {
    var text: String
    @Binding var isOn: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)

            HStack {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .stroke(Color.black, lineWidth: 0.1)
                        .frame(width: 40, height: 40)
                       
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)

                    Image(systemName: "checkmark.circle")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                }
                VStack(alignment: .leading) {
            
                        Text(text)
                            .font(.caption)
                            .foregroundColor(Color.black.opacity(0.5))

                                                
                    
                   
                }
                .padding(.leading, 8)
                Spacer()

                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(.blue)
            }
            .padding()
        }
    }
}

