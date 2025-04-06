//
//  GameManager.swift
//  Pentominoes
//
//  Created by Tej Patel on 23/09/24.
//

import Foundation
import SwiftUI

@Observable
class GameManager {
    var game = Game()
    var leftPuzzles = ["Board0", "Board1", "Board2", "Board3"]
    var rightPuzzles = ["Board4", "Board5", "Board6", "Board7"]
    
    init() {
        game.leftPuzzles = leftPuzzles
        game.rightPuzzles = rightPuzzles
        
        loadPentominoOutlines()
        loadPuzzleOutlines()
        loadSolutions()
        
        game.currentPuzzleOutline = [game.puzzleOutlines[0]]
        
        initializePieces()
    }
    
    func loadPentominoOutlines() {
        if let url = Bundle.main.url(forResource: "PentominoOutlines", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let outlines = try JSONDecoder().decode([PentominoOutline].self, from: data)
                game.pentominoOutlines = outlines
                //print("Loaded Pentomino Outlines:", outlines)
            } catch {
                //print("Error loading PentominoOutlines:", error)
            }
        }
    }
    
    func loadPuzzleOutlines() {
        if let url = Bundle.main.url(forResource: "PuzzleOutlines", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let puzzles = try JSONDecoder().decode([PuzzleOutline].self, from: data)
                game.puzzleOutlines = puzzles
                //print("Loaded Puzzle Outlines:", puzzles)
            } catch {
                //print("Error loading PuzzleOutlines:", error)
            }
        }
    }
    
    func loadSolutions() {
        if let url = Bundle.main.url(forResource: "Solutions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let solutions = try JSONDecoder().decode([String: [String: Solution]].self, from: data)
                game.solutions = solutions
                //print("Loaded Solutions:", solutions)
            } catch {
                //print("Error loading Solutions:", error)
            }
        }
    }
    
    func initializePieces() {
        game.pentominoPieces = []
        
        var xRaw : Int
        var yRaw : Int
        
        for (index, outline) in game.pentominoOutlines.enumerated() {
            
            xRaw = (40 * (((120*(index%4)) + 20) / 40))
            yRaw = (40 * (((120*(index/4)) + 20) / 40))
            
            game.pentominoPieces.append(Piece(position: Position(x: xRaw + 1 + 40*(index%4) , y: yRaw + 1 + 80*(index/4) ), outline: outline, RotationState: RotationState()))
            
        }
    }
    
    func updatePiecePosition(at index: Int, newX: Int, newY: Int) {
        
        var xOffset = 0
        var yOffset = 0
        
        if((index == 1 || index == 5) && game.pentominoPieces[index].RotationState.z == 1){
            
            xOffset += 20
            yOffset -= 20
        }
        if((index == 1 || index == 5) && game.pentominoPieces[index].RotationState.z == 3){
            
            xOffset += 20
            yOffset -= 20
        }
        
        if (newY < 0){
            yOffset = yOffset - 50
        }
        game.pentominoPieces[index].position = Position(x: 40*(newX/40) + xOffset , y: 40*(newY/40) + 40 + yOffset )
    }
    
    func rotateShape(at index: Int) {
        
        var xOffset = 0
        var yOffset = 0
        
        
        if((index == 1 || index == 5) && game.pentominoPieces[index].RotationState.z == 1){
            xOffset += 20
            yOffset -= 20
        }
        if((index == 1 || index == 5) && game.pentominoPieces[index].RotationState.z == 3){
            xOffset += 20
            yOffset -= 20
        }
        
        
        if(game.pentominoPieces[index].RotationState.x == 1){
            game.pentominoPieces[index].RotationState.z = (game.pentominoPieces[index].RotationState.z + 2) % 4
        }
        game.pentominoPieces[index].RotationState.z = (game.pentominoPieces[index].RotationState.z + 1) % 4
        
        let temp = game.pentominoPieces[index].outline.size.width
        
        game.pentominoPieces[index].outline.size.width = game.pentominoPieces[index].outline.size.height
        
        game.pentominoPieces[index].outline.size.height = temp
        
        
    }
    
    func flipShape(at index: Int) {
        game.pentominoPieces[index].RotationState.x = (game.pentominoPieces[index].RotationState.x + 1) % 2
    }
    
    func solvePuzzle(){
        
        
        initializePieces()
        
        let currentSolution = game.solutions[game.currentPuzzleOutline[0].name]
        
        var xOffset = 0
        var yOffset = 0
        
        
        for (index, piece) in game.pentominoPieces.enumerated() {
            
            switch currentSolution?[piece.outline.name]?.orientation {
            case "up":
                game.pentominoPieces[index].RotationState.x = 0
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 0
                
            case "right":
                game.pentominoPieces[index].RotationState.x = 0
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 1
                
                let temp = game.pentominoPieces[index].outline.size.width
                
                game.pentominoPieces[index].outline.size.width = game.pentominoPieces[index].outline.size.height
                
                game.pentominoPieces[index].outline.size.height = temp
                
            case "down":
                game.pentominoPieces[index].RotationState.x = 0
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 2
                
            case "left":
                game.pentominoPieces[index].RotationState.x = 0
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 3
                
                let temp = game.pentominoPieces[index].outline.size.width
                
                game.pentominoPieces[index].outline.size.width = game.pentominoPieces[index].outline.size.height
                
                game.pentominoPieces[index].outline.size.height = temp
                
            case "upMirrored":
                game.pentominoPieces[index].RotationState.x = 1
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 0
                
            case "rightMirrored":
                game.pentominoPieces[index].RotationState.x = 1
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 3
                
                let temp = game.pentominoPieces[index].outline.size.width
                
                game.pentominoPieces[index].outline.size.width = game.pentominoPieces[index].outline.size.height
                
                game.pentominoPieces[index].outline.size.height = temp
                
            case "downMirrored":
                game.pentominoPieces[index].RotationState.x = 1
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 2
                
            case "leftMirrored":
                game.pentominoPieces[index].RotationState.x = 1
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 1
                
                let temp = game.pentominoPieces[index].outline.size.width
                
                game.pentominoPieces[index].outline.size.width = game.pentominoPieces[index].outline.size.height
                
                game.pentominoPieces[index].outline.size.height = temp
                
            default:
                game.pentominoPieces[index].RotationState.x = 0
                game.pentominoPieces[index].RotationState.y = 0
                game.pentominoPieces[index].RotationState.z = 0
                
            }
            
            if((index == 1 || index == 5) && game.pentominoPieces[index].RotationState.z == 1){
                xOffset += 20
                yOffset -= 20
            }
            if((index == 1 || index == 5) && game.pentominoPieces[index].RotationState.z == 3){
                xOffset += 20
                yOffset -= 20
            }
            
            game.pentominoPieces[index].position.x = xOffset  + (currentSolution?[piece.outline.name]?.x ?? 0) * 40
            game.pentominoPieces[index].position.y = yOffset - 570 + (currentSolution?[piece.outline.name]?.y ?? 0) * 40
            
            xOffset = 0
            yOffset = 0
            
        }
        
    }
    
    func doesNothing(){}
    
}
