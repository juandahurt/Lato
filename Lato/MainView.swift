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
    @State private var audioPlayer = AudioPlayer()
    
    var body: some View {
        Group {
            if showBoard {
                BoardView(
                    latoGame: latoGame,
                    onSettingsTap: {
                        isMovingToSettingsView = true
                        withAnimation(.easeIn) {
                            showBoard = false
                        }
                    },
                    isMovingToSettingsView: $isMovingToSettingsView
                )
                .transition(.slide)
            } else {
                SettingsView(
                    onBackTap: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                            isMovingToSettingsView = false
                        }
                        withAnimation(.easeIn) {
                            showBoard = true
                        }
                    }
                )
                .transition(.slide)
            }
        }.onAppear {
            audioPlayer.play("background.mp3")
            if !userSettings.playSound {
                audioPlayer.pause()
            }
        }
        .onChange(of: userSettings.playSound) { playSound in
            if !playSound { audioPlayer.pause() }
            else { audioPlayer.play() }
        }
    }
}
