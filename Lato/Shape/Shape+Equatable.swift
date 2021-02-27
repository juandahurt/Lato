//
//  Shape+Equatable.swift
//  Lato
//
//  Created by juandahurt on 27/02/21.
//

import Foundation

extension Shape: Equatable {
    static func ==(lhs: Shape, rhs: Shape) -> Bool {
        lhs.id == rhs.id
    }
}
