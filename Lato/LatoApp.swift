//
//  LatoApp.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import SwiftUI

@main
struct LatoApp: App {
    @State private var showBoard = true
    @State private var isMovingToSettingsView = false
    private var latoGame = LatoGame()
    
    var body: some Scene {
        WindowGroup {
            if showBoard {
                BoardView(
                    latoGame: latoGame,
                    onSettingsTap: {
                        isMovingToSettingsView = true
                        showBoard = false
                    },
                    isMovingToSettingsView: $isMovingToSettingsView
                )
            } else {
                SettingsView(
                    onBackTap: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isMovingToSettingsView = false
                        }
                        showBoard = true
                    }
                )
            }
        }
    }
}
