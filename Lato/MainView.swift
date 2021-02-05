//
//  MainView.swift
//  Lato
//
//  Created by juandahurt on 5/02/21.
//

import SwiftUI

struct MainView: View {
    @State private var showBoard = true
    @State private var isMovingToSettingsView = false
    private var latoGame = LatoGame()
    @EnvironmentObject var userSettings: UserSettings
    
    @ViewBuilder var body: some View {
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
                    if userSettings.selectedBoard.id != latoGame.board.id {
                        latoGame.restart()
                        latoGame.set(board: userSettings.selectedBoard)
                    }
                }
            )
        }
    }
}
