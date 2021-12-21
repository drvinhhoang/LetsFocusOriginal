//
//  TimerViewModel.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

class TimerManager: ObservableObject {
    
    
    @Published var timerSetting      = TimerSetting.shared {
        didSet {
            setSeconds()
        }
    }
   
    @Published var tempSetting: TimerSetting  = TimerSetting.shared
    @Published var isRunning                  = false
    @Published var section: Int               = 0
    @Published var isBreakTime: Bool          = false
    @Published var isLongBreak: Bool          = false
    @Published var seconds: Int               = TimerSetting.shared.focusTime * 60
    
    @Published var alertItem: AlertItem?
 
    private var timer = Timer()

    func updateTimeSetting() {
       self.timerSetting = tempSetting
        self.seconds = timerSetting.focusTime * 60
    }
    
    func saveChanges() {
        PersistenceManager.shared.saveChanges(for: timerSetting) {[weak self] alertItem in
            guard let self = self else { return }
            self.alertItem = alertItem
        }
    }
    
    func retrieveSetting() {
        PersistenceManager.shared.retrieveSetting { timerSetting in
            self.timerSetting = timerSetting
            self.tempSetting = timerSetting
        }
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
                    seconds -= 60
                    if seconds <= 0 {
                        time.invalidate()
                        isRunning = false
                        // when senconds to 0, change to breaking time
                        if !isBreakTime {
                            section += 1
                        }
                        isBreakTime.toggle()
                        setSeconds()
                    }
                }
            } else {
                timer.invalidate()
            }
    }
    
    
    func stopTimer() {
        timer.invalidate()
        isRunning = false
    }
    
    
    func setSeconds() {
        if isBreakTime {
            if section % 4 == 0 && section > 0 {
                isLongBreak = true
                
            } else {
                isLongBreak = false
            }
            
            if isLongBreak {
                seconds = timerSetting.longBreak * 60
            } else {
                seconds = timerSetting.shortBreak * 60
            }
            
        } else {
            seconds = timerSetting.focusTime * 60
        }
    }

    
    func resetTimer() {
        stopTimer()
        seconds = tempSetting.focusTime * 60
        isBreakTime = false
    }
    
    
    
}
