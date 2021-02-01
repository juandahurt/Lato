//
//  LatoGame.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

class LatoGame: ObservableObject {
    @Published private(set) var game = Game(board: .diamond)
    
    var board: Board {
        game.board
    }
    
    func put(shape: Shape, at coordinates: [Board.Coordiante]) {
        game.put(shape: shape, at: coordinates)
    }
    
    func checkForFullLines(at coordinates: [Board.Coordiante]) -> [[Int]] {
        game.checkForFullLines(at: coordinates)
    }
}
