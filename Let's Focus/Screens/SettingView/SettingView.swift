//
//  SettingView.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

struct SettingView: View {  
    @EnvironmentObject var timerManager: TimerManager
    
    var focusTime = 1...50
    var shortBreak = [5, 10, 15, 20, 25, 30]
    var longBreak = [ 5, 10, 15, 20, 25, 30]
    var sections = 1...20
    
    var body: some View {    
        NavigationView {
            VStack {
                Form {
                    Picker("Focus time", selection: $timerManager.tempSetting.focusTime) {
                        ForEach(focusTime, id: \.self) {
                            Text(String($0))
                        }
                    }
                    Picker("Short break", selection: $timerManager.tempSetting.shortBreak) {
                        ForEach(shortBreak, id: \.self) {
                            Text(String($0))
                        }
                    }
                    Picker("Long break", selection: $timerManager.tempSetting.longBreak) {
                        ForEach(longBreak, id: \.self) {
                            Text(String($0))
                        }
                    }
                    Section(header: Text("Intervals")) {
                        Picker("Intervals", selection: $timerManager.tempSetting.totalSections) {
                            ForEach(sections, id: \.self) {
                                Text(String($0))
                            }
                        }

                    }
                }
                .background(Color.backgroundLightColor)
            }
            .navigationTitle("Setting")
            .navigationBarItems(trailing: Button {
                timerManager.updateTimeSetting()
                timerManager.saveChanges()
            } label: {
                Text("Save")
                    .foregroundColor(.red)            }
            )
            .alert(item: $timerManager.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
        }
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
