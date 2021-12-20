//
//  TimerViewModel.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    
    @AppStorage("setting") private var timerSetting: Data?
    @Published var pomoTimer        = TimerModel.defaultTimeModel
    @Published var tempTimerModel    = TimerModel.defaultTimeModel
    #warning("6")
    @Published var isRunning         = false
    #warning("5")
    @Published var section: Int      = 0
    #warning("7")
    @Published var isBreakTime: Bool = false
    #warning("8")
    @Published var isLongBreak: Bool = false
    
    
    @Published var alertItem: AlertItem?
    
    private var timer = Timer()

    func saveChanges() {
        let data = try? JSONEncoder().encode(pomoTimer)
        timerSetting = data
        alertItem = AlertContext.saveSuccessful
    }
    
    func retrieveSetting() {
        guard let timerSetting = timerSetting else { return}
        do { let temp = try JSONDecoder().decode(TimerModel.self, from: timerSetting)
            pomoTimer = temp
            tempTimerModel = temp
        } catch {
            
        }
        
    }
    
    func updateTimeSetting() {
        pomoTimer = tempTimerModel
        
    }
    
    #warning("1")
    // Set color for timerView's timer
    func setTimerColor() -> (primary: Color, secondary: Color) {
        if isBreakTime {
            return isLongBreak ? (.green, .green) : (.blue, .blue)
        } else {
            return (.brandPrimary, .secondaryBrand)
        }
    }
    
    
    #warning("2")
    func startTimer() {
        
            isRunning.toggle()
            if isRunning {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[self] time in
                    pomoTimer.seconds -= 1
                    if pomoTimer.seconds <= 0 {
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
    
    
    #warning("3")
    func stopTimer() {
        timer.invalidate()
        isRunning = false
    }
    
    
    #warning("4")
    func setBreakTime() {
        if isBreakTime {
            if section % 4 == 0 && section > 0 {
                isLongBreak = true
                
            } else {
                isLongBreak = false
            }
            
            if isLongBreak {
                pomoTimer.seconds = pomoTimer.longBreak * 60
            } else {
                pomoTimer.seconds = pomoTimer.shortBreak * 60
            }
            
        } else {
            pomoTimer.seconds = pomoTimer.focusTime * 60
        }
    }
    
    
    
    func setTimeWhenXDismissPressed() {
        stopTimer()
        pomoTimer.seconds = tempTimerModel.seconds
        isBreakTime = false
    }
    
    
    
}
