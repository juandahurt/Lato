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
                .resizable()
                .frame(width: UIScreen.main.bounds.height / 40, height: UIScreen.main.bounds.height / 40)
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
                .font(.custom("Poppins-SemiBold", size: UIScreen.main.bounds.height / 35))
                .padding(.top, 20)
            soundEffects
        }
    }
    
    var soundEffects: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: UIScreen.main.bounds.height / 70)
                    .fill(Color("Background-Dark"))
                    .frame(width: UIScreen.main.bounds.height / 30, height: UIScreen.main.bounds.height / 30)
                Group {
                    if userSettings.playSound {
                        Image("Check")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height / 45, height: UIScreen.main.bounds.height / 45)
                    }
                }
            }
            Text("Sound")
                .font(Font.system(size: UIScreen.main.bounds.height / 40))
                .foregroundColor(.black)
        }
        .onTapGesture {
            userSettings.setPlaySound(value: !userSettings.playSound)
        }
    }
    
    var boardPicker: some View {
        VStack(alignment: .leading) {
            Text("Board")
                .foregroundColor(.black)
                .font(.custom("Poppins-SemiBold", size: UIScreen.main.bounds.height / 35))
                .padding(.top, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Board.boards) { board in
                        VStack {
                            
                            GeometryReader { geometry in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Background-Dark"))
                                    draw(board: board, in: geometry.size)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.height / 8, height: UIScreen.main.bounds.height / 7)
                            Group {
                                if board.id == userSettings.selectedBoard.id {
                                    Circle()
                                        .fill(Color("Background-Dark"))
                                        .frame(width: UIScreen.main.bounds.height / 14, height: UIScreen.main.bounds.height / 40)
                                }
                            }
                        }
                        .onTapGesture {
                            userSettings.selectedBoard = board
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 7 + UIScreen.main.bounds.height / 40 + 10)
            }
        }
    }
    
    func draw(board: Board, in size: CGSize) -> some View {
        VStack(spacing: size.width / 70) {
            ForEach(board.layout.indices, id: \.self) { rowIndex in
                HStack(spacing: size.width / 70) {
                    ForEach(0..<board.layout[rowIndex].count) { colIndex in
                        RoundedRectangle(cornerRadius: size.height / 30)
                            .fill(board.layout[rowIndex][colIndex] == 1 ? Color("Background") : Color("Background-Dark"))
                            .frame(width: size.height / 12, height: size.height / 12)
                    }
                }
            }
        }
    }
    
    var credits: some View {
        HStack {
            Spacer()
            Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String + " - Juan Hurtado")
                .foregroundColor(Color("Background-Dark"))
                .font(.custom("Poppins-SemiBold", size: UIScreen.main.bounds.height / 50))
            Spacer()
        }
        .padding(.bottom, 15)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 40) {
            navBar
            settings
            boardPicker
            Spacer()
            credits
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, UIScreen.main.bounds.width / 20)
        .padding(.top, UIScreen.main.bounds.height / 40)
        .background(Color("Background"))
        .statusBar(hidden: true)
    }
}
