//
//  SettingsUIView.swift
//  3things
//
//  Created by Sean Mc Mains on 12/27/19.
//  Copyright © 2019 Sean McMains. All rights reserved.
//

import SwiftUI

struct SettingsUIView: View {
    @ObservedObject var settings: Settings
    var dismissAction: (() -> Void)
    
    var body: some View {
        
        VStack {
            
            Text("3things Settings")
                .font(.title)
                .padding()
            
            Form {
                Text("Adjust the time that 3things reminds you to set your goals for the day")
                    .padding([.top, .bottom
                    ], 15)
                    .font(.headline)
                
                DatePicker(selection: $settings.reminderTime, displayedComponents: .hourAndMinute,
                           label: { Text("Reminder Time:")
                            .font(.headline) })
                    .accentColor(Color("3thingsBlue"))
                    .accessibility(identifier: "reminderPicker")
            }
            
            Spacer()
            
            Button(action: dismissAction ) {
                Text("Done")
                    .foregroundColor(Color("3thingsBlue"))
                    .bold()
                    .padding()
            }
        }
        .navigationBarTitle(Text("Settings"), displayMode: .inline)
        .frame(minWidth: 0,
               idealWidth: .infinity,
               maxWidth: .infinity,
               minHeight: 0,
               idealHeight: .infinity,
               maxHeight: .infinity,
               alignment: .top)
    }
}

struct SettingsUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUIView(settings: Settings(), dismissAction: {}
        )
    }
}
