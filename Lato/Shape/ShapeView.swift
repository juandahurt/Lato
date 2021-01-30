//
//  ShapeView.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import SwiftUI

struct ShapeView: View {
    var shape: Shape
    var onChanged: () -> Void
    var locations: Binding<[CGRect]>
    @State private var dragAmount: CGSize = .zero
    @State private var cellIndex = 0
    
    var body: some View {
        ForEach(shape.layout.indices) { rowIndex in
            HStack {
                ForEach(0..<shape.layout[rowIndex].count) { colIndex in
                    Group {
                        if shape.getCellAt(row: rowIndex, col: colIndex).state == .alive {
                            GeometryReader { geometry in
                                CellView(color: shape.chooseShapeColor(for: shape.color))
                                    .onChange(of: dragAmount) { _ in
                                        locations.wrappedValue[cellIndex] = geometry.frame(in: .global)
                                        cellIndex += 1
                                        if cellIndex == 4 { cellIndex = 0 }
                                    }
                            }
                            .frame(width: 40, height: 40)
                        } else {
                            CellView(color: .clear)
                        }
                    }
                }
            }
        }
        .offset(dragAmount)
        .gesture(
            DragGesture(coordinateSpace: .global)
                .onChanged { value in
                    withAnimation(.linear) {
                        dragAmount.width = value.translation.width
                        dragAmount.height = value.translation.height
                    }
                    onChanged()
                }
                .onEnded { value in
                    dragAmount = .zero
                }
        )
    }
}
