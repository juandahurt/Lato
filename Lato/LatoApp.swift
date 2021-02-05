//
//  LatoApp.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import SwiftUI

@main
struct LatoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(UserSettings(selectedBoard: .diamond))
        }
    }
}
