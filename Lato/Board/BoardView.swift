//
//  BoardView.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import SwiftUI

struct BoardView: View {
    var board: Board
    
    @State private var possibleDropCoordinates: [[Int]] = []
    @State private var cellsLocations: [[CGRect]] = [[CGRect]](repeating: [CGRect](repeating: .zero, count: 7), count: 10)
    @State private var currentShapeLocations: [CGRect] = [CGRect](repeating: .zero, count: 4)
    
    init(board: Board) {
        self.board = board
    }
    
    func updatePossibleDropLocation() {
        var validCells = 0
        possibleDropCoordinates.removeAll()
        for row in cellsLocations.indices {
            for col in cellsLocations[row].indices {
                for shapeLocation in currentShapeLocations {
                    if cellsLocations[row][col].contains(CGPoint(x: shapeLocation.midX, y: shapeLocation.midY)) {
                        if validCells < 4 {
                            validCells += 1
                            possibleDropCoordinates.append([row, col])
                        }
                        else {
                            break
                        }
                    }
                }
            }
        }
        if validCells < 4 { possibleDropCoordinates.removeAll() }
    }
    
    var body: some View {
        VStack {
            ForEach(board.layout.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<board.layout[rowIndex].count) { colIndex in
                        Group {
                            if board.cellAt(row: rowIndex, col: colIndex).state == .dead { EmptyView() }
                            else {
                                CellView(color: possibleDropCoordinates.contains([rowIndex, colIndex]) ? Color("Yellow").opacity(0.4) : Color("Background-Dark"))
                                .overlay(
                                    GeometryReader { geometry in
                                        Rectangle()
                                            .fill(Color.clear)
                                            .onAppear {
                                                cellsLocations[rowIndex][colIndex] = geometry.frame(in: .global)
                                            }
                                    }
                                )
                            }
                        }
                    }
                }
            }
            ShapeView(shape: .square, onChanged: updatePossibleDropLocation, locations: $currentShapeLocations)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .statusBar(hidden: true)
    }
}
