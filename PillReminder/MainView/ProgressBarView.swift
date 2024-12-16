//
//  ProgressBarView.swift
//  PillReminder
//
//  Created by Daniel Paredes on 07/12/24.
//

import SwiftUI
import UIKit
import AVFoundation

struct ProgressBarView: View {

    @State var progressValue: Float = 0.0
    
    @ObservedObject var medicinesVM: MedicineViewModel
    
    var body: some View {
        
        ZStack {
            
            DateText(medicinesVM: medicinesVM)
            
            VStack{
                ProgressBar(progress: .constant( medicinesVM.progress), color: .blue)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .scaleEffect(x: 1, y: 1, anchor: .center)
                    .animation(.easeInOut(duration: 0.5), value: medicinesVM.progress)
                
                    .frame(width: 300.0, height: 220.0)
                    .padding(20.0).onAppear() {
                        progressValue = 0.5
                        //progressValue = medicinesVM.progress
                    }
                    .onChange(of: medicinesVM.progress) { newValue in
                        if newValue >= 1.0 {
                            triggerVibration(withDelay: 1.0)
                        }
                        
                    }
            }
        }
    }
    private func triggerVibration(withDelay delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)

        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = Color.blue
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0), value: progress)
        }
    }
}


#Preview {
    ProgressBarView(medicinesVM: MedicineViewModel())  // Pass the shared ViewModel instance
}

