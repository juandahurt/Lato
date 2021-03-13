//
//  Board+Boards.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

extension Board {

    static let rectangle = Board(
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
    
    static let test = Board(
        layout: [
            [1,1,1,1],
            [1,1,1,1],
            [1,1,1,1],
            [1,1,1,1]
        ]
    )
}
