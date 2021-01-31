//
//  Shape.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Shape {
    enum Color {
        case red, yellow, black, blue
    }
    var id: Int
    var layout: [[Int]]
    var color: Color
    
    func getCellAt(row: Int, col: Int) -> Cell {
        let value = layout[row][col]
        return Cell(value: value)
    }
}
