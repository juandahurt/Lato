//
//  Shape+Color.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import Foundation
import SwiftUI

extension Shape {
    static func chooseShapeColor(for color: Shape.Color) -> SwiftUI.Color {
        switch color {
        case .red:
            return SwiftUI.Color("Red")
        case .yellow:
            return SwiftUI.Color("Yellow")
        case .black:
            return SwiftUI.Color("Black")
        case .blue:
            return SwiftUI.Color("Blue")
        }
    }
}
