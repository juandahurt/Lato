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
    var bestScore: Int
    var currentShape: Shape = Shape.shapes.randomElement()!
    var isGameOver: Bool = false
    
    init(board: Board) {
        self.board = board
        bestScore = Int(FileHelper().read(contentsOf: "score.txt") ?? "0")!
    }
    
    mutating func put(shape: Shape, at coordinates: [Board.Coordiante]) {
        for coordinate in coordinates {
            board.layout[coordinate.row][coordinate.col] = shape.id
        }
        moves += 1
        if currentScoreIsTheBest() {
            updateBestScore()
        }
        var randomShape = Shape.shapes.randomElement()!
        while randomShape == currentShape {
            randomShape = Shape.shapes.randomElement()!
        }
        currentShape = randomShape
        // rotate the shape randomly
        var rotationTimes: Int = .random(in: 0...4)
        while rotationTimes > 0 {
            currentShape.rotate()
            rotationTimes -= 1
        }
    }
    
    mutating func checkIfCurrentShapeFitsInBoard() {
        // NOTA: Yo me pregunto: ¿exitirá alguna forma de hacer esta busqueda pero de forma eficiente?
        let shapeLayout = currentShape.layout
        var placesWhereTheShapeFits = 0
        let rowLimit = board.layout.count - shapeLayout.count
        let colLimit = board.layout[0].count - shapeLayout[0].count
        var foundAPlace = false
        mainLoop: for boardRow in 0...rowLimit {
            for boardCol in 0...colLimit {
                placesWhereTheShapeFits = 0
                for shapeRow in shapeLayout.indices {
                    for shapeCol in shapeLayout[0].indices {
                        let shapeCell = currentShape.getCellAt(row: shapeRow, col: shapeCol)
                        let boardCell = board.cellAt(row: boardRow + shapeRow, col: boardCol + shapeCol)
                        if  shapeCell.state == .alive && boardCell.shape == .none {
                            placesWhereTheShapeFits += 1
                            if placesWhereTheShapeFits == 4 {
                                foundAPlace = true
                                break mainLoop
                            }
                        }
                    }
                }
            }
        }
        isGameOver = !foundAPlace
    }
    
    private func currentScoreIsTheBest() -> Bool {
        let best = Int(FileHelper().read(contentsOf: "score.txt") ?? "0")!
        return moves > best
    }
    
    mutating private func updateBestScore() {
        FileHelper().write(String(moves), to: "score.txt")
        bestScore = moves
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
    
    mutating func restart() {
        moves = 0
        isGameOver = false
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
