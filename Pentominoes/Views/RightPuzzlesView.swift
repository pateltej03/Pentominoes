//
//  RightPuzzlesView.swift
//  Pentominoes
//
//  Created by Tej Patel on 23/09/24.
//

import Foundation
import SwiftUI

struct RightPuzzlesView: View {
    @Environment(GameManager.self) var manager
    var rightPuzzles : [String]
    var body: some View {
        VStack{
            VStack{
                ForEach(rightPuzzles.indices, id: \.self){ index in
                    Button(action: {
                        manager.game.currentPuzzleOutline = [manager.game.puzzleOutlines[index+4]]
                        manager.game.solveDisabled = false
                    }) {
                        Image(rightPuzzles[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120) 
                        
                    }
                }
                
            }
            Button(action: manager.solvePuzzle){
                Text("Solve")
                    .font(.system(size: 36, weight: .bold))
                    .bold()
                    .padding(5)
                    .foregroundStyle(Color.red)
                
            }.disabled(manager.game.solveDisabled)
        }
    }
}

#Preview {
    AppView()
}
