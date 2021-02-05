//
//  UserSettings.swift
//  Lato
//
//  Created by juandahurt on 3/02/21.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var selectedBoard: Board
    
    init(selectedBoard: Board) {
        self.selectedBoard = selectedBoard
    }
}
