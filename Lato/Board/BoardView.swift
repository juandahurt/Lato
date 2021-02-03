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
    @State private var currentShape: Shape = Shape.shapes.randomElement()!
    @State private var dyingLines: [[Int]] = []
    @State private var shapeOffset: CGFloat = -200

    func updatePossibleDropLocation() {
        dyingLines.removeAll()
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
        dyingLines.removeAll()
        if possibleDropCoordinates.count == 4 {
            withAnimation(.easeIn) {
                latoGame.put(shape: currentShape, at: possibleDropCoordinates)
            }
            dyingLines = latoGame.checkForFullLines(at: possibleDropCoordinates)
            possibleDropCoordinates.removeAll()
            var randomShape = Shape.shapes.randomElement()!
            while randomShape == currentShape {
                randomShape = Shape.shapes.randomElement()!
            }
            currentShape = randomShape
        }
    }
    
    func draw(cell: Cell, at coordinate: Board.Coordiante) -> some View {
        var color: Color = .clear
        var animateRow = false
        var animateCol = false
        if dyingLines.count > 0 {
            animateRow = dyingLines[0].contains(coordinate.row)
            animateCol = dyingLines[1].contains(coordinate.col)
        }
        let animate = animateRow || animateCol
        
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
            .animation(animate ? Animation.easeOut.delay(Double(coordinate.row + coordinate.col) * 0.05) : .none)
    }
    
    var score: some View {
        VStack {
            Text("SCORE")
                .foregroundColor(Color("Red"))
            Text("\(latoGame.score)")
                .foregroundColor(Color("Black"))
                .transition(.scale)
                .id("Score \(latoGame.score)")
        }
        .font(.custom("Poppins-SemiBold", size: 20))
    }
    
    var moves: some View {
        VStack {
            Text("MOVES")
                .foregroundColor(Color("Blue"))
            Text("\(latoGame.moves)")
                .foregroundColor(Color("Black"))
                .transition(.scale)
                .id("Score \(latoGame.moves)")
        }
        .font(.custom("Poppins-SemiBold", size: 20))
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    score
                    Spacer()
                    moves
                }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
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
            }
            .padding(.bottom, 80)
            VStack {
                Spacer()
                ShapeView(
                    shape: currentShape,
                    onChanged: updatePossibleDropLocation,
                    onDrop: onDropShape,
                    locations: $currentShapeLocations
                )
                .onTapGesture {
                    latoGame.rotate(&currentShape)
                }
                .offset(x: shapeOffset, y: 0)
                .onAppear {
                    withAnimation(.easeInOut) {
                        shapeOffset = 0
                    }
                }
                .onChange(of: currentShape.id) { _ in
                    shapeOffset = -200
                    withAnimation(.easeInOut) {
                        shapeOffset = 0
                    }
                }
                HStack {
                    Image("Restart")
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                latoGame.restart()
                                currentShape = Shape.shapes.randomElement()!
                            }
                        }
                    Spacer()
                    Image("Settings")
                }
                .padding(.horizontal, 20)
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .statusBar(hidden: true)
    }
}
