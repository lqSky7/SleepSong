//
//  ContentView.swift
//  SleepSong
//
//  Created by ca5 on 07/12/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var coffeeA = 2
    @State private var SleepAmount = 8.0
    @State private var predictedWakeUpTime: Date = Date.now
    @State private var showMessage = false
    
    
    var body : some View{
        NavigationStack{
            VStack(spacing: 20){
                Text("Your wake up time?").font(.headline).bold()
                DatePicker("Select wakeup time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                
                Text("Desired amount of sleep?").font(.headline).bold()
                Stepper("\(SleepAmount.formatted()) Hours", value: $SleepAmount, in: 4...14, step: 0.5).padding(.horizontal, 40)
                
                Text("Coffee per day?").font(.headline).bold()
                Stepper(
                    coffeeA == 1 ? "1 Cup" : 
                    "\(coffeeA.formatted()) Cups", value: $coffeeA, in: 0...10)
                .padding(.horizontal, 40)
                
                Button("Calculate", role: .confirm){
                    calc()
                }.buttonStyle(.glassProminent).padding().tint(.primary)
                
                if(showMessage){
                    VStack{
                        Text("You should sleep by...")
                        Text("\(predictedWakeUpTime.formatted(date: .omitted, time: .shortened))")
                    }
                }
                
                
            }.navigationTitle("SleepSong").navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    func calc(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let userEnteredDateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let userEnteredHour = userEnteredDateComponents.hour! * 60 * 60
            let userEnteredMinute = userEnteredDateComponents.minute! * 60
            
            let predictedValue = try model.prediction(wake: Double(userEnteredHour + userEnteredMinute), estimatedSleep: Double(SleepAmount), coffee: Double(coffeeA))
            
            predictedWakeUpTime = wakeUp - predictedValue.actualSleep
            
        } catch {
            print("Something went wrong...")
        }
         showMessage = true
            }
        }
    



#Preview {
    ContentView()
}
