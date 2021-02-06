//
//  UserSettings.swift
//  Lato
//
//  Created by juandahurt on 3/02/21.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var selectedBoard: Board
    @Published var playSound: Bool
    
    init(selectedBoard: Board) {
        self.selectedBoard = selectedBoard
        playSound = Bool(FileHelper().read(contentsOf: "sound.txt") ?? "true")!
    }
    
    func setPlaySound(value: Bool) {
        FileHelper().write(String(value), to: "sound.txt")
        playSound = value
    }
}
