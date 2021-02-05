//
//  Game.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Game {
    var board: Board
    var moves: Int = 0
    var currentShape: Shape = Shape.shapes.randomElement()!
    
    mutating func put(shape: Shape, at coordinates: [Board.Coordiante]) {
        for coordinate in coordinates {
            board.layout[coordinate.row][coordinate.col] = shape.id
        }
        moves += 1
        var randomShape = Shape.shapes.randomElement()!
        while randomShape == currentShape {
            randomShape = Shape.shapes.randomElement()!
        }
        currentShape = randomShape
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
        return [fullRows, fullCols]
    }
    
    mutating func rotate() {
        currentShape.rotate()
    }
    
    mutating func restart() {
        moves = 0
        for rowIndex in board.layout.indices {
            for colIndex in board.layout[rowIndex].indices {
                if board.layout[rowIndex][colIndex] != 0 {
                    board.layout[rowIndex][colIndex] = 1
                }
            }
        }
    }
    
    mutating func set(board: Board) {
        self.board = board
    }
}
