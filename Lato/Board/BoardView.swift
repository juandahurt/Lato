//
//  BoardView.swift
//  Lato
//
//  Created by juandahurt on 30/01/21.
//

import SwiftUI

struct BoardView: View {
    @StateObject var latoGame: LatoGame
    @State private var possibleDropCoordinates: [Board.Coordiante] = []
    @State private var cellsLocations: [[CGRect]] = [[CGRect]](repeating: [CGRect](repeating: .zero, count: 7), count: 10)
    @State private var currentShapeLocations: [CGRect] = [CGRect](repeating: .zero, count: 4)
    @State private var currentShape: Shape = .snake

    func updatePossibleDropLocation() {
        var validCells = 0
        possibleDropCoordinates.removeAll()
        for row in cellsLocations.indices {
            for col in cellsLocations[row].indices {
                for shapeLocation in currentShapeLocations {
                    if cellsLocations[row][col].contains(CGPoint(x: shapeLocation.midX, y: shapeLocation.midY)) && latoGame.board.cellAt(row: row, col: col).shape == nil {
                        if validCells < 4 {
                            validCells += 1
                            possibleDropCoordinates.append(Board.Coordiante(row: row, col: col))
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
    
    func onDropShape() {
        if possibleDropCoordinates.count == 4 {
            latoGame.put(shape: currentShape, at: possibleDropCoordinates)
            currentShape = Shape.shapes.randomElement()!
        }
    }
    
    func draw(cell: Cell, at coordinate: Board.Coordiante) -> some View {
        var color: Color = .clear
        
        if let shape = cell.shape {
            color = Shape.chooseShapeColor(for: shape.color)
        } else {
            color = possibleDropCoordinates.contains(coordinate) ? Shape.chooseShapeColor(for: currentShape.color).opacity(0.4) : Color("Background-Dark")
        }
        
        return CellView(color: color)
        .overlay(
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .onAppear {
                        cellsLocations[coordinate.row][coordinate.col] = geometry.frame(in: .global)
                    }
            }
        )
            .animation(.easeIn)
    }
    
    var body: some View {
        VStack {
            Spacer()
            ForEach(latoGame.board.layout.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<latoGame.board.layout[rowIndex].count) { colIndex in
                        Group {
                            if latoGame.board.cellAt(row: rowIndex, col: colIndex).state == .dead {
                                CellView(color: Color("Background"))
                            }
                            else {
                                draw(cell: latoGame.board.cellAt(row: rowIndex, col: colIndex), at: Board.Coordiante(row: rowIndex, col: colIndex))
                            }
                        }
                    }
                }
            }
            Spacer()
            ShapeView(
                shape: currentShape,
                onChanged: updatePossibleDropLocation,
                onDrop: onDropShape,
                locations: $currentShapeLocations
            )
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .statusBar(hidden: true)
    }
}
