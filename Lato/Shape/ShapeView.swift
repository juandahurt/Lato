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
    var onDrop: () -> Void
    var locations: Binding<[CGRect]>
    @State private var dragAmount: CGSize = .zero
    @State private var cellIndex = 0
    @State private var scale = CGSize(width: 0.4, height: 0.4)
    
    var body: some View {
        VStack {
            ForEach(shape.layout.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<shape.layout[rowIndex].count, id: \.self) { colIndex in
                        Group {
                            if shape.getCellAt(row: rowIndex, col: colIndex).state == .alive {
                                GeometryReader { geometry in
                                    CellView(color: Shape.chooseShapeColor(for: shape.color))
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
        }
        .scaleEffect(scale)
        .offset(dragAmount)
        .gesture(
            DragGesture(coordinateSpace: .global)
                .onChanged { value in
                    scale = CGSize(width: 1, height: 1)
                    withAnimation(.linear) {
                        dragAmount.width = value.translation.width
                        dragAmount.height = value.translation.height
                    }
                    onChanged()
                }
                .onEnded { value in
                    scale = CGSize(width: 0.4, height: 0.4)
                    dragAmount = .zero
                    onDrop()
                }
        )
    }
}
