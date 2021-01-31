//
//  Piece.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Cell {
    enum State {
        case alive
        case dead
    }
    
    var state: State
    var shape: Shape?
    
    init(value: Int) {
        if value == 0 {
            state = .dead
        } else {
            state = .alive
            if value != 1 {
                for shape in Shape.shapes {
                    if shape.id == value {
                        self.shape = shape
                        break
                    }
                }
            }
        }
    }
}
