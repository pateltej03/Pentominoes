//
//  PieceView.swift
//  Pentominoes
//
//  Created by Tej Patel on 23/09/24.
//

import Foundation
import SwiftUI

struct PieceView: View {
    var piece: Piece
    var color: Color
    var index: Int
    @Environment(GameManager.self) var manager
    
    var body: some View {
        ZStack {
            PentominoView(outline: piece.outline, color: color)
                .rotationEffect(.degrees(Double(90 * piece.RotationState.z)), anchor: .center)
                .scaleEffect(x: (piece.RotationState.x != 0) ? -1 : 1, y: (piece.RotationState.y != 0) ? -1 : 1)
            
        }
        
    }
    
}
