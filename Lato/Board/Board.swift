//
//  Board.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Board {
    var layout: [[Int]]
    
    struct Coordiante: Equatable {
        var row: Int
        var col: Int
    }
    
    func cellAt(row: Int, col: Int) -> Cell {
        let value = layout[row][col]
        return Cell(value: value)
    }
}
