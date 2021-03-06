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
    var size: CGSize
    @State private var dragAmount: CGSize = .zero
    @State private var cellIndex = 0
    @State private var scale = CGSize(width: 0.35, height: 0.35)
    
    var body: some View {
        VStack(spacing: size.width / 70) {
            ForEach(shape.layout.indices, id: \.self) { rowIndex in
                HStack(spacing: size.width / 70) {
                    ForEach(0..<shape.layout[rowIndex].count, id: \.self) { colIndex in
                        Group {
                            if shape.getCellAt(row: rowIndex, col: colIndex).state == .alive {
                                GeometryReader { geometry in
                                    CellView(color: Shape.chooseShapeColor(for: shape.color), in: size)
                                        .onChange(of: dragAmount) { _ in
                                            locations.wrappedValue[cellIndex] = geometry.frame(in: .global)
                                            cellIndex += 1
                                            if cellIndex == 4 { cellIndex = 0 }
                                        }
                                }
                                .frame(width: size.height / 12, height: size.height / 12)
                            } else {
                                CellView(color: .clear, in: size)
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
                    scale = CGSize(width: 0.35, height: 0.35)
                    dragAmount = .zero
                    onDrop()
                }
        )
    }
}
