//
//  PieceView.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import SwiftUI

struct CellView: View {
    var color: Color = Color("Background-Dark")
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(color)
            .frame(width: 40, height: 40)
    }
}
