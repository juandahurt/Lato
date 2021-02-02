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
        layoutRotatedBy0: [
            [1,1],
            [1,1]
        ],
        layoutRotatedBy90: [
            [1,1],
            [1,1]
        ],
        layoutRotatedBy180: [
            [1,1],
            [1,1]
        ],
        layoutRotatedBy270: [
            [1,1],
            [1,1]
        ],
        color: .yellow
    )
    
    static let line = Shape(
        id: -2,
        layoutRotatedBy0: [
            [1,1,1,1]
        ],
        layoutRotatedBy90: [
            [1],
            [1],
            [1],
            [1]
        ],
        layoutRotatedBy180: [
            [1,1,1,1]
        ],
        layoutRotatedBy270: [
            [1],
            [1],
            [1],
            [1]
        ],
        color: .red
    )
    
    static let snake = Shape(
        id: -3,
        layoutRotatedBy0: [
            [1,1,0],
            [0,1,1]
        ],
        layoutRotatedBy90: [
            [0,1],
            [1,1],
            [1,0]
        ],
        layoutRotatedBy180: [
            [1,1,0],
            [0,1,1]
        ],
        layoutRotatedBy270: [
            [0,1],
            [1,1],
            [1,0]
        ],
        color: .black
    )
    
    static let mrT = Shape(
        id: -4,
        layoutRotatedBy0: [
            [1,1,1],
            [0,1,0]
        ],
        layoutRotatedBy90: [
            [0,0,1],
            [0,1,1],
            [0,0,1]
        ],
        layoutRotatedBy180: [
            [0,1,0],
            [1,1,1]
        ],
        layoutRotatedBy270: [
            [1,0],
            [1,1],
            [1,0]
        ],
        color: .blue
    )

    static let msL = Shape(
        id: -5,
        layoutRotatedBy0: [
            [1,0],
            [1,0],
            [1,1]
        ],
        layoutRotatedBy90: [
            [1,1,1],
            [1,0,0],
        ],
        layoutRotatedBy180: [
            [1,1],
            [0,1],
            [0,1]
        ],
        layoutRotatedBy270: [
            [0,0,1],
            [1,1,1],
        ],
        color: .green
    )
    
    static let shapes: [Shape] = [.square, .line, .snake, .mrT, .msL]
}
