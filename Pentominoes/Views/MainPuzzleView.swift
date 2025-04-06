//
//  MainPuzzleView.swift
//  Pentominoes
//
//  Created by Tej Patel on 23/09/24.
//


import Foundation
import SwiftUI

struct MainPuzzleView: View {
    @Environment(GameManager.self) var manager
    
    var body: some View {
        ZStack {
            
            GridShapeView(rows: manager.game.gridRows, columns: manager.game.gridColumns, width: manager.game.gridWidth, height: manager.game.gridHeight)
                .frame(width: manager.game.gridWidth, height: manager.game.gridHeight)
            
            let puzzleOutline = manager.game.currentPuzzleOutline[0]
            PuzzleViewWithHoles(outline: puzzleOutline)
        }
    }
}

#Preview {
    AppView()
}
