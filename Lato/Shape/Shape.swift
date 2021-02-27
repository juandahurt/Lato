//
//  Shape.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Shape {
    enum Color {
        case red, yellow, black, blue, green
    }
    enum RotationAngle {
        case none, ninety, oneEighty, twoSeventy
    }
    var id: Int
    var layout: [[Int]]
    var layoutRotatedBy0: [[Int]]
    var layoutRotatedBy90: [[Int]]
    var layoutRotatedBy180: [[Int]]
    var layoutRotatedBy270: [[Int]]
    var color: Color
    var rotation: RotationAngle = .none
    
    init(id: Int, layoutRotatedBy0: [[Int]], layoutRotatedBy90: [[Int]], layoutRotatedBy180: [[Int]], layoutRotatedBy270: [[Int]], color: Color) {
        self.id = id
        self.layout = layoutRotatedBy0
        self.layoutRotatedBy0 = layoutRotatedBy0
        self.layoutRotatedBy90 = layoutRotatedBy90
        self.layoutRotatedBy180 = layoutRotatedBy180
        self.layoutRotatedBy270 = layoutRotatedBy270
        self.color = color
    }
    
    func getCellAt(row: Int, col: Int) -> Cell {
        let value = layout[row][col]
        return Cell(value: value)
    }
    
    mutating func rotate() {
        switch rotation {
        case .none:
            rotation = .ninety
            layout = layoutRotatedBy90
            break
        case .ninety:
            rotation = .oneEighty
            layout = layoutRotatedBy180
            break
        case .oneEighty:
            rotation = .twoSeventy
            layout = layoutRotatedBy270
            break
        case .twoSeventy:
            rotation = .none
            layout = layoutRotatedBy0
            break
        }
    }
}
