//
//  PiecesView.swift
//  Pentominoes
//
//  Created by Tej Patel on 24/09/24.
//

import Foundation
import SwiftUI

struct PiecesView: View {
    var pieces: [Piece]
    @State var offsets: [CGSize]
    @Environment(GameManager.self) var manager
    
    init(pieces: [Piece]) {
        self.pieces = pieces
        self._offsets = State(initialValue: Array(repeating: .zero, count: pieces.count))
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach(pieces.indices, id: \.self) { index in
                
                PieceView(piece: pieces[index], color: Color.blue, index: index)
                    .offset(offsets[index])
                    .frame(width: 40 * CGFloat((pieces[index].outline.size.width)), height: 40 * CGFloat(pieces[index].outline.size.height), alignment: .topLeading)
                    .position(x: CGFloat(pieces[index].centerPosition.x), y: CGFloat(pieces[index].centerPosition.y))
                    .gesture(tapAndLongPressGesture(for: index))
                    .gesture(dragGesture(for: index))
                
            }
            
        }
        .frame(width: 560, height: 560, alignment: .topLeading)
        
    }
    
    func dragGesture(for index: Int) -> some Gesture {
        DragGesture()
            .onChanged { value in
                dragChanged(with: value, index: index)
            }
            .onEnded { value in
                updatePosition(with: value, index: index)
            }
    }
    
    func tapAndLongPressGesture(for index: Int) -> some Gesture {
        TapGesture()
            .onEnded {
                
                manager.rotateShape(at: index)
                
                if((index == 1) && manager.game.pentominoPieces[index].RotationState.z == 1){
                    manager.game.pentominoPieces[index].position.x += 20
                    manager.game.pentominoPieces[index].position.y += 20
                }
                if((index == 1) && manager.game.pentominoPieces[index].RotationState.z == 2){
                    manager.game.pentominoPieces[index].position.x -= 20
                    manager.game.pentominoPieces[index].position.y -= 20
                }
                if((index == 1) && manager.game.pentominoPieces[index].RotationState.z == 3){
                    manager.game.pentominoPieces[index].position.x -= 20
                    manager.game.pentominoPieces[index].position.y -= 20
                }
                if((index == 1) && manager.game.pentominoPieces[index].RotationState.z == 0){
                    manager.game.pentominoPieces[index].position.x += 20
                    manager.game.pentominoPieces[index].position.y += 20
                }
                
                if((index == 5) && manager.game.pentominoPieces[index].RotationState.z == 1){
                    manager.game.pentominoPieces[index].position.x -= 20
                    manager.game.pentominoPieces[index].position.y -= 20
                }
                if((index == 5) && manager.game.pentominoPieces[index].RotationState.z == 2){
                    manager.game.pentominoPieces[index].position.x += 20
                    manager.game.pentominoPieces[index].position.y += 20
                }
                if((index == 5) && manager.game.pentominoPieces[index].RotationState.z == 3){
                    manager.game.pentominoPieces[index].position.x += 20
                    manager.game.pentominoPieces[index].position.y += 20
                }
                if((index == 5) && manager.game.pentominoPieces[index].RotationState.z == 0){
                    manager.game.pentominoPieces[index].position.x -= 20
                    manager.game.pentominoPieces[index].position.y -= 20
                }
                
                if((index == 8 || index == 9 || index == 10) && manager.game.pentominoPieces[index].RotationState.z == 1){
                    manager.game.pentominoPieces[index].position.x += 40
                    manager.game.pentominoPieces[index].position.y += 40
                }
                if((index == 8 || index == 9 || index == 10) && manager.game.pentominoPieces[index].RotationState.z == 2){
                    manager.game.pentominoPieces[index].position.x -= 40
                    manager.game.pentominoPieces[index].position.y -= 40
                }
                if((index == 8 || index == 9 || index == 10) && manager.game.pentominoPieces[index].RotationState.z == 3){
                    manager.game.pentominoPieces[index].position.x -= 40
                    manager.game.pentominoPieces[index].position.y -= 40
                }
                if((index == 8 || index == 9 || index == 10) && manager.game.pentominoPieces[index].RotationState.z == 0){
                    manager.game.pentominoPieces[index].position.x += 40
                    manager.game.pentominoPieces[index].position.y += 40
                }
                
                if((index == 11) && manager.game.pentominoPieces[index].RotationState.z == 1){
                    manager.game.pentominoPieces[index].position.x += 80
                    manager.game.pentominoPieces[index].position.y += 80
                }
                if((index == 11) && manager.game.pentominoPieces[index].RotationState.z == 2){
                    manager.game.pentominoPieces[index].position.x -= 80
                    manager.game.pentominoPieces[index].position.y -= 80
                }
                if((index == 11) && manager.game.pentominoPieces[index].RotationState.z == 3){
                    manager.game.pentominoPieces[index].position.x -= 80
                    manager.game.pentominoPieces[index].position.y -= 80
                }
                if((index == 11) && manager.game.pentominoPieces[index].RotationState.z == 0){
                    manager.game.pentominoPieces[index].position.x += 80
                    manager.game.pentominoPieces[index].position.y += 80
                }
                
                
            }
            .simultaneously(
                with: LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        manager.flipShape(at: index)
                    }
            )
    }
    
    func dragChanged(with value: DragGesture.Value, index: Int) {
        offsets[index] = value.translation
    }
    
    func updatePosition(with value: DragGesture.Value, index: Int) {
        var newX = Int((CGFloat(pieces[index].position.x)))
        var newY = Int((CGFloat(pieces[index].position.y)))
        
        newX = newX + Int(value.translation.width)
        newY = newY + Int(value.translation.height)
        
        manager.updatePiecePosition(at: index, newX: newX, newY: newY)
        
        offsets[index] = .zero
        
    }
    
}
