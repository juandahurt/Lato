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
    
    var score: Int {
        game.score
    }
    
    var moves: Int {
        game.moves
    }
    
    func put(shape: Shape, at coordinates: [Board.Coordiante]) {
        game.put(shape: shape, at: coordinates)
    }
    
    func checkForFullLines(at coordinates: [Board.Coordiante]) -> [[Int]] {
        game.checkForFullLines(at: coordinates)
    }
    
    func rotate(_ shape: inout Shape) {
        game.rotate(&shape)
    }
    
    func restart() {
        game.restart()
    }
}
