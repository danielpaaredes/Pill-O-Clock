//
//  PillReminderApp.swift
//  PillReminder
//
//  Created by Daniel Paredes on 05/12/24.
//

import SwiftUI

@main
struct PillReminderApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                Tab("Current", systemImage: "pill"){
                    ContentView()
                }
                Tab("History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90"){
                    HistoryView()
                }
            }
        }
    }
}
