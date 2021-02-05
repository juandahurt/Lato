//
//  UserSettings.swift
//  Lato
//
//  Created by juandahurt on 3/02/21.
//

import Foundation

class UserSettings: Equatable, ObservableObject {
    @Published var selectedBoard: Board
    
    static func == (lhs: UserSettings, rhs: UserSettings) -> Bool {
        lhs.selectedBoard.id == rhs.selectedBoard.id
    }
    
    init(selectedBoard: Board) {
        self.selectedBoard = selectedBoard
    }
}
