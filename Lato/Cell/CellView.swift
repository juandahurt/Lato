//
//  PieceView.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import SwiftUI

struct CellView: View {
    var color: Color
    var size: CGSize
    
    init(color: Color, in size: CGSize) {
        self.color = color
        self.size = size
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: size.height / 30)
            .fill(color)
            .frame(width: size.height / 12, height: size.height / 12)
    }
}
