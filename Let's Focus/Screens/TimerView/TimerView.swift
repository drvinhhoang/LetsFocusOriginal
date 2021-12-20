//
//  TimerView.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var timerViewmodel: TimerViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundLightColor
            
            VStack {
                VStack {
                    Text("Let's Foccus")
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    Text("\(timerViewmodel.section)/\(timerViewmodel.pomoTimer.totalSections)")
                        .font(.title)
                        .fontWeight(.medium)
                }
                .foregroundColor(Color("BrandPrimary"))
                .padding(.bottom, 40)
                
                if timerViewmodel.isRunning || (!timerViewmodel.isRunning && timerViewmodel.isBreakTime) || (!timerViewmodel.isRunning && timerViewmodel.pomoTimer.seconds < timerViewmodel.tempTimerModel.seconds) {
                    // Explain code above:
                    // Only display XDismissButton when:
                    // - timer is running
                    // - Timer is not running but in breaktime
                    // - Timer is stopped in focus mode (current seconds < total seconds, total seconds is tempTimerModel's seconds)
                    
                    TimerCicle(second: timerViewmodel.pomoTimer.seconds, primaryColor: timerViewmodel.setTimerColor().primary, secondaryColor: timerViewmodel.setTimerColor().secondary)
                        .overlay(Button {
                            timerViewmodel.setTimeWhenXDismissPressed()
                            timerViewmodel.stopTimer()
                            print("Dismiss Tapped!")
                        } label: {
                            XDismissButton()
                            
                        }, alignment: .topTrailing)
                } else {
                    TimerCicle(second: timerViewmodel.pomoTimer.seconds, primaryColor: timerViewmodel.setTimerColor().primary, secondaryColor: timerViewmodel.setTimerColor().secondary)
                }
    
                Button {
                    timerViewmodel.startTimer()
                } label: {
                    StartButton(isRunning: timerViewmodel.isRunning)
                }
                .padding(.top, 40)
            }
        }
        .onAppear {
            timerViewmodel.retrieveSetting()
        }
    }
}

struct TimerCicle: View {
    var second: Int
    var primaryColor: Color
    var secondaryColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 290, height:  290)
                .foregroundColor(primaryColor)
            Circle()
                .frame(width: 285, height:  285)
                .foregroundColor(.white)
            Circle()
                .frame(width: 260, height: 260)
                .foregroundColor(secondaryColor)
                .blur(radius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            Circle()
                .frame(width: 250, height: 250)
                .foregroundColor(secondaryColor)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Circle()
                .frame(width: 230, height: 230)
                .foregroundColor(.white)
            HStack {
                Text(String(format: "%02d", second / 60))
                Text(":")
                Text(String(format: "%02d", second % 60))
            }
            .font(.largeTitle)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
        
    }
}
