//
//  Piece.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

struct Cell {
    enum State {
        case alive, dead
    }
    
    var state: State
    
    init(value: String) {
        if value == "0" {
            state = .dead
        } else {
            state = .alive
        }
    }
}
