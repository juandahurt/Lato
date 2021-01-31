//
//  Shape+Shapes.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation

extension Shape {
    static let square = Shape(
        id: -1,
        layout: [
            [1,1],
            [1,1]
        ],
        color: .yellow
    )
    
    static let line = Shape(
        id: -2,
        layout: [
            [1,1,1,1],
        ],
        color: .red
    )
    
    static let snake = Shape(
        id: -3,
        layout: [
            [1,1,0],
            [0,1,1]
        ],
        color: .black
    )
    
    static let mrT = Shape(
        id: -4,
        layout: [
            [1,1,1],
            [0,1,0]
        ],
        color: .blue
    )
    
    static let shapes: [Shape] = [.square, .line, .snake, .mrT]
}
