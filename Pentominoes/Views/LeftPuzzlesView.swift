//
//  PuzzlesView.swift
//  Pentominoes
//
//  Created by Tej Patel on 22/09/24.
//

import Foundation
import SwiftUI

struct LeftPuzzlesView: View {
    @Environment(GameManager.self) var manager
    var leftPuzzles : [String]
    var body: some View {
        VStack{
            VStack{
                
                ForEach(leftPuzzles.indices, id: \.self){ index in
                    Button(action: {
                        manager.game.currentPuzzleOutline = [manager.game.puzzleOutlines[index]]
                        manager.game.solveDisabled = false
                        if (index == 0){
                            manager.game.solveDisabled = true
                        }
                    }) {
                        Image(leftPuzzles[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                        
                    }
                }
                
            }
            Button(action: manager.initializePieces){
                Text("Reset")
                    .font(.system(size: 36, weight: .bold))
                    .bold()
                    .padding(5)
                    .foregroundStyle(Color.red)
                
            }
        }
    }
}

#Preview {
    AppView()
}
