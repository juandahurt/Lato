//
//  Board.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Board {
    var layout: [String]
    
    func cellAt(row: Int, col: Int) -> Cell {
        let value = layout[row].substring(with: col..<col+1)
        return Cell(value: value)
    }
}
