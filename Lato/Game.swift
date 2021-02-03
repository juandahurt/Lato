//
//  Game.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Game {
    var board: Board
    var score: Int = 0
    var moves: Int = 0
    
    mutating func put(shape: Shape, at coordinates: [Board.Coordiante]) {
        for coordinate in coordinates {
            board.layout[coordinate.row][coordinate.col] = shape.id
        }
        score += 5
        moves += 1
    }
    
    mutating func checkForFullLines(at coordinates: [Board.Coordiante]) -> [[Int]] {
        // TODO: Mejorar la busqueda! Como? No se
        var fullRows: [Int] = []
        let layout = board.layout
        for row in layout.indices {
            if layout[row].first(where: { $0 > 0 }) == nil {
                fullRows.append(row)
                for col in layout[row].indices {
                    if layout[row][col] < 0 {
                        board.layout[row][col] = 1
                    }
                }
            }
        }
        var fullCols: [Int] = []
        for col in 0..<layout[0].count {
            var colElements: [Int] = []
            for row in layout.indices {
                colElements.append(layout[row][col])
            }
            if colElements.first(where: { $0 > 0 }) == nil {
                fullCols.append(col)
                for row in layout.indices {
                    if layout[row][col] < 0 {
                        board.layout[row][col] = 1
                    }
                }
            }
        }
        score += 10 * (fullRows.count + fullCols.count)
        return [fullRows, fullCols]
    }
    
    func rotate(_ shape: inout Shape) {
        shape.rotate()
    }
    
    mutating func restart() {
        score = 0
        moves = 0
        self.board = .diamond
    }
}
