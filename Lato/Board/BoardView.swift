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
    @State private var dyingLines: [[Int]] = []
    @State private var shapeOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var boardOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var currentShapeContainerSize: CGSize = .zero
    var onSettingsTap: () -> Void
    var isMovingToSettingsView: Binding<Bool>
    var intersitial = Interstitial()

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
                latoGame.put(shape: latoGame.currentShape, at: possibleDropCoordinates)
            }
            dyingLines = latoGame.checkForFullLines(at: possibleDropCoordinates)
            possibleDropCoordinates.removeAll()
            withAnimation(Animation.spring().delay(0.5)) {
                latoGame.checkIfCurrentShapeFitsInBoard()
            }
        }
    }
    
    func draw(cell: Cell, at coordinate: Board.Coordiante, in size: CGSize) -> some View {
        var color: Color = .clear
        var animateRow = false
        var animateCol = false
        if dyingLines.count > 0 {
            animateRow = dyingLines[0].contains(coordinate.row)
            animateCol = dyingLines[1].contains(coordinate.col)
        }
        let animate = animateRow || animateCol || isMovingToSettingsView.wrappedValue
        
        if let shape = cell.shape {
            color = Shape.chooseShapeColor(for: shape.color)
        } else {
            color = possibleDropCoordinates.contains(coordinate) ? Shape.chooseShapeColor(for: latoGame.currentShape.color).opacity(0.4) : Color("Background-Dark")
        }
        
        return CellView(color: color, in: size)
        .offset(x: boardOffset, y: 0)
        .overlay(
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .onAppear {
                        boardOffset = 0
                        cellsLocations[coordinate.row][coordinate.col] = geometry.frame(in: .global)
                    }
            }
        )
            .animation(animate ? Animation.easeOut.delay(Double(coordinate.row + coordinate.col) * 0.04) : .none)
    }
    
    var moves: some View {
        Text("\(latoGame.moves)")
            .foregroundColor(Color("Black"))
            .transition(.scale)
            .id("Moves \(latoGame.moves)")
            .font(.custom("Poppins-SemiBold", size: UIScreen.main.bounds.height / 16))
    }
    
    var best: some View {
        HStack {
            Text("BEST: \(latoGame.best)")
                .font(.custom("Poppins-SemiBold", size: UIScreen.main.bounds.height / 35))
                .foregroundColor(Color("Background-Dark"))
        }
    }
    
    var board: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.width / 70) {
                ForEach(latoGame.board.layout.indices, id: \.self) { rowIndex in
                    HStack(spacing: geometry.size.width / 70) {
                        ForEach(0..<latoGame.board.layout[rowIndex].count) { colIndex in
                            Group {
                                if latoGame.board.cellAt(row: rowIndex, col: colIndex).state == .dead {
                                    CellView(color: Color("Background"), in: geometry.size)
                                }
                                else {
                                    draw(cell: latoGame.board.cellAt(row: rowIndex, col: colIndex), at: Board.Coordiante(row: rowIndex, col: colIndex), in: geometry.size)
                                }
                            }
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: nil, alignment: .center)
            .overlay(Color.clear.onAppear {
                currentShapeContainerSize = geometry.size
            })
        }
    }
    
    var _body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Spacer()
                        best
                    }
                    moves
                }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                board
                Spacer()
            }
            .padding(.bottom, 80)
            VStack {
                Spacer()
                ShapeView(
                    shape: latoGame.currentShape,
                    onChanged: updatePossibleDropLocation,
                    onDrop: onDropShape,
                    locations: $currentShapeLocations,
                    size: currentShapeContainerSize
                )
                .offset(x: shapeOffset, y: 0)
                .onAppear {
                    withAnimation(Animation.easeInOut.delay(0.2)) {
                        shapeOffset = 0
                    }
                }
                .onChange(of: latoGame.currentShape.id) { _ in
                    shapeOffset = -UIScreen.main.bounds.width
                    withAnimation(Animation.easeInOut.delay(0.2)) {
                        shapeOffset = 0
                    }
                }
                HStack {
                    reStart
                    Spacer()
                    Image("Settings")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height / 35, height: UIScreen.main.bounds.height / 35)
                        .onTapGesture {
                            onSettingsTap()
                        }
                }
                .padding(.horizontal, 20)
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.bottom, 15)
        }
    }
    
    var reStart: some View {
        Image("Restart")
            .resizable()
            .frame(width: UIScreen.main.bounds.height / 35, height: UIScreen.main.bounds.height / 35)
            .onTapGesture {
                latoGame.restart()
                intersitial.showAd()
            }
    }
    
    var gameOver: some View {
        ZStack {
            Color("Black").opacity(0.6)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                VStack {
                    Text("GAME OVER")
                        .font(.custom("Poppins-SemiBold", size: UIScreen.main.bounds.height / 35))
                        .foregroundColor(.black)
                    reStart
                }
            }.frame(maxWidth: UIScreen.main.bounds.width * 0.45, maxHeight: UIScreen.main.bounds.height * 0.15)
        }
    }
    
    @ViewBuilder var body: some View {
        ZStack {
            _body
            if latoGame.isGameOver {
                gameOver
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .statusBar(hidden: true)
    }
}
