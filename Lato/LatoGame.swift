//
//  LatoGame.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

class LatoGame: ObservableObject {
    @Published private(set) var game = Game(board: .rectangle)
    
    var board: Board {
        game.board
    }
    
    var moves: Int {
        game.moves
    }
    
    var best: Int {
        game.bestScore
    }
    
    var currentShape: Shape {
        game.currentShape
    }
    
    var isGameOver: Bool {
        game.isGameOver
    }
    
    func put(shape: Shape, at coordinates: [Board.Coordiante]) {
        game.put(shape: shape, at: coordinates)
    }
    
    func checkForFullLines(at coordinates: [Board.Coordiante]) -> [[Int]] {
        game.checkForFullLines(at: coordinates)
    }
    
    func checkIfCurrentShapeFitsInBoard() {
        game.checkIfCurrentShapeFitsInBoard()
    }
    
    func restart() {
        game.restart()
    }
    
    func set(board: Board) {
        game.board = board
    }
}
