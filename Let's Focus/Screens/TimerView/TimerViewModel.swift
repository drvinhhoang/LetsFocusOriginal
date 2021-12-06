//
//  TimerViewModel.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    
    @AppStorage("setting") private var timerSetting: Data?
    @Published var timerModel        = TimerModel.defaultTimeModel
    @Published var tempTimerModel    = TimerModel.defaultTimeModel
    @Published var isRunning         = false
    @Published var section: Int      = 0
    @Published var isBreakTime: Bool = false
    @Published var isLongBreak: Bool = false
    @Published var alertItem: AlertItem?
    
    private var timer = Timer()

    func saveChanges() {
        let data = try? JSONEncoder().encode(timerModel)
        timerSetting = data
        alertItem = AlertContext.saveSuccessful
    }
    
    func retrieveSetting() {
        guard let timerSetting = timerSetting else { return}
        do { let temp = try JSONDecoder().decode(TimerModel.self, from: timerSetting)
            timerModel = temp
            tempTimerModel = temp
        } catch {
            
        }
        
    }
    
    func updateTimeSetting() {
        timerModel = tempTimerModel
        
    }
    
    
    // Set color for timerView's timer
    func setTimerColor() -> (primary: Color, secondary: Color) {
        if isBreakTime {
            return isLongBreak ? (.green, .green) : (.blue, .blue)
        } else {
            return (.brandPrimary, .secondaryBrand)
        }
    }
    
    func startTimer() {
        
            isRunning.toggle()
            if isRunning {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[self] time in
                    timerModel.seconds -= 1
                    if timerModel.seconds <= 0 {
                        time.invalidate()
                        isRunning = false
                        // when senconds to 0, change to breaking time
                        if !isBreakTime {
                            section += 1
                        }
                        isBreakTime.toggle()
                        setBreakTime()
                    }
                }
            } else { // if isRunning == false
                timer.invalidate()
            }
   
    }
    
    func stopTimer() {
        timer.invalidate()
        isRunning = false
    }
    
    func setBreakTime() {
        if isBreakTime {
            if section % 4 == 0 && section > 0 {
                isLongBreak = true
                
            } else {
                isLongBreak = false
            }
            
            if isLongBreak {
                timerModel.seconds = timerModel.longBreak * 60
            } else {
                timerModel.seconds = timerModel.shortBreak * 60
            }
            
        } else {
            timerModel.seconds = timerModel.focusTime * 60
        }
    }
    
    
    
    func setTimeWhenXDismissPressed() {
        stopTimer()
        timerModel.seconds = tempTimerModel.seconds
        isBreakTime = false
    }
    
    
    
}
