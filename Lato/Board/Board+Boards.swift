//
//  Board+Boards.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

extension Board {
    static let diamond = Board(
        id: 1,
        layout: [
            [0,0,1,1,1,0,0],
            [0,1,1,1,1,1,0],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,0,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [0,1,1,1,1,1,0],
            [0,0,1,1,1,0,0],
        ]
    )
    
    static let square = Board(
        id: 2,
        layout: [
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1],
        ]
    )
    
    static let boards: [Board] = [.diamond, .square]
}
