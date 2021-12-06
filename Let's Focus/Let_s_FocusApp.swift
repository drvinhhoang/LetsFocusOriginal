//
//  Let_s_FocusApp.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

@main
struct Let_s_FocusApp: App {
    var body: some Scene {
        WindowGroup {
            LetsFocusTabView().environmentObject(TimerViewModel())
        }
    }
}
