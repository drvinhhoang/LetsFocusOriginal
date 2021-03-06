//
//  TimerView.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        ZStack {
            Color.backgroundLightColor
            
            VStack {
                VStack {
                    Text("Let's Foccus")
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    Text("\(timerManager.section)/\(timerManager.timerSetting.totalSections)")
                        .font(.title)
                        .fontWeight(.medium)
                }
                .foregroundColor(Color("BrandPrimary"))
                .padding(.bottom, 40)
                
                if timerManager.isRunning || (!timerManager.isRunning && timerManager.isBreakTime) || (!timerManager.isRunning && timerManager.seconds < timerManager.seconds) {

                    TimerCicle(second: timerManager.seconds, primaryColor: timerManager.setTimerColor().primary, secondaryColor: timerManager.setTimerColor().secondary)
                        .overlay(Button {
                            timerManager.resetTimer()
                            timerManager.stopTimer()
                            print("Dismiss Tapped!")
                        } label: {
                            XDismissButton()
                            
                        }, alignment: .topTrailing)
                } else {
                    TimerCicle(second: timerManager.seconds, primaryColor: timerManager.setTimerColor().primary, secondaryColor: timerManager.setTimerColor().secondary)
                }
    
                Button {
                    timerManager.startTimer()
                } label: {
                    StartButton(isRunning: timerManager.isRunning)
                }
                .padding(.top, 40)
            }
        }
        .onAppear {
            timerManager.retrieveSetting()
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
        } // ZStack
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()      
    }
}
