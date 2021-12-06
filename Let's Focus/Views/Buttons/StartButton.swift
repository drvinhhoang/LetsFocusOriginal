//
//  StartButton.swift
//  Let's Focus
//
//  Created by VINH HOANG on 13/10/2021.
//

import SwiftUI

struct StartButton: View {
    
    var isRunning: Bool
    
    var body: some View {
        if isRunning {
            Text("Stop")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(width: 240, height: 70)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
        } else {
            Text("Start")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(width: 240, height: 70)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
        }
       
    }
}

struct StartButton_Previews: PreviewProvider {
    static var previews: some View {
        StartButton(isRunning: true)
    }
}
