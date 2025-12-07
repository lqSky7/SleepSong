//
//  ContentView.swift
//  SleepSong
//
//  Created by ca5 on 07/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var coffee = 2
    @State private var SleepAmount = 8.0
    var body : some View{
        NavigationStack{
            VStack(spacing: 20){
                Text("Your wake up time?").font(.headline).bold()
                DatePicker("Select wakeup time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                Text("Desired amount of sleep?").font(.headline).bold()
                Stepper("\(SleepAmount.formatted()) Hours", value: $SleepAmount, in: 4...14, step: 0.5).padding(.horizontal, 40)
                Text("Coffee per day?").font(.headline).bold()
                Stepper("\(coffee.formatted()) Cups", value: $coffee, in: 0...10).padding(.horizontal, 40)
                
            }.navigationTitle("SleepSong").navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    ContentView()
}
