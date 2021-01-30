//
//  Shape.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Shape {
    enum Color {
        case red, yellow
    }
    var id: String
    var height: Int
    var width: Int
    var layout: [String]
    var color: Color
    
    func getCellAt(row: Int, col: Int) -> Cell {
        let value = layout[row].substring(with: col..<col+1)
        return Cell(value: value)
    }
}
