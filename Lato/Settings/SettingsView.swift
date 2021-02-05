//
//  SettingsView.swift
//  Lato
//
//  Created by juandahurt on 3/02/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserSettings
    var onBackTap: () -> Void
    
    var navBar: some View {
        HStack {
            Image("Back")
                .onTapGesture {
                    onBackTap()
                }
            Spacer()
        }
    }
    
    var settings: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .foregroundColor(.black)
                .font(.custom("Poppins-SemiBold", size: 20))
                .padding(.top, 20)
            soundEffects
        }
    }
    
    var soundEffects: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("Background-Dark"))
                    .frame(width: 40, height: 40)
                Group {
                    if userSettings.playSound {
                        Image("Check")
                    }
                }
            }
            Text("Sound")
                .foregroundColor(.black)
        }
        .onTapGesture {
            userSettings.playSound.toggle()
        }
    }
    
    var boardPicker: some View {
        VStack(alignment: .leading) {
            Text("Board")
                .foregroundColor(.black)
                .font(.custom("Poppins-SemiBold", size: 20))
                .padding(.top, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Board.boards) { board in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Background-Dark"))
                                .frame(width: 125, height: 173)
                            draw(board: board)
                            Group {
                                if board.id == userSettings.selectedBoard.id {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 30, height: 30)
                                        Image("Check")
                                    }
                                    .offset(x: 0, y: 173 / 2)
                                }
                            }
                        }
                        .onTapGesture {
                            userSettings.selectedBoard = board
                        }
                    }
                }
                .frame(height: 173 + 30)
            }
        }
    }
    
    func draw(board: Board) -> some View {
        VStack(spacing: 2) {
            ForEach(board.layout.indices, id: \.self) { rowIndex in
                HStack(spacing: 2) {
                    ForEach(0..<board.layout[rowIndex].count) { colIndex in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(board.layout[rowIndex][colIndex] == 1 ? Color("Background") : Color("Background-Dark"))
                            .frame(width: 11.86, height: 11.86)
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            navBar
            settings
            boardPicker
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.top, 30)
        .background(Color("Background"))
        .statusBar(hidden: true)
    }
}
