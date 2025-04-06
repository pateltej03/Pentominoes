//
//  ContentView.swift
//  Pentominoes
//
//  Created by Tej Patel on 22/09/24.
//

import SwiftUI

struct AppView: View {
    @Environment(GameManager.self) var manager
    var body: some View {
        @Bindable var manager = manager
        ZStack {
            
            Color(red: 0.9, green: 0.8, blue: 0.6)
            
            VStack{
                HStack{
                    LeftPuzzlesView(leftPuzzles: manager.leftPuzzles)
                    MainPuzzleView()
                    RightPuzzlesView(rightPuzzles: manager.rightPuzzles)
                }
                
                PiecesView(pieces: manager.game.pentominoPieces)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            
        }.edgesIgnoringSafeArea(.all)
        
    }
}

#Preview {
    AppView()
}

