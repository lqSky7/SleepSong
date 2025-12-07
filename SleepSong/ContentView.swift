//
//  ContentView.swift
//  SleepSong
//
//  Created by ca5 on 07/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var sleepHours : Double = 8.0
    @State var dateToday : Date = Date.now
    var body: some View {
        Stepper("Sleep Hours \(sleepHours.formatted())", value: $sleepHours, in: 2...16, step: 0.5)
            .labelsHidden()
        DatePicker("Pick a date", selection: $dateToday,
                   in: Date.now...,
                   displayedComponents: .hourAndMinute).labelsHidden()
    }
}

#Preview {
    ContentView()
}
