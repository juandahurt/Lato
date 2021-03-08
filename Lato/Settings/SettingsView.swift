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
    
    var version: some View {
        HStack {
            Spacer()
            Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
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
            Spacer()
            version
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, UIScreen.main.bounds.width / 20)
        .padding(.top, UIScreen.main.bounds.height / 40)
        .background(Color("Background"))
        .statusBar(hidden: true)
    }
}
