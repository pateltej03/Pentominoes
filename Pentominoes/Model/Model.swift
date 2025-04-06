//
//  Pentominoes.swift
//  Assets for Assignment 4
//
//  Created by Alfares, Nader on 1/28/23.
//
import Foundation
import SwiftUI


//Mark:- Shapes models

struct Point: Codable {
    let x: Int
    let y: Int
}

struct Size: Codable {
    var width: Int
    var height: Int
}

typealias Outline = [Point]

struct PentominoOutline: Codable {
    let name: String
    var size: Size
    let outline: [Point]
}

struct PuzzleOutline: Codable {
    let name: String
    var size: Size
    let outlines: [[Point]]
}

struct Solution: Codable {
    var x: Int
    var y: Int
    var orientation: String
}

//Mark:- Pieces Model

struct Position: Codable {
    var x : Int = 0
    var y : Int = 0
}

struct Piece: Codable {
    var position : Position = Position()
    var outline : PentominoOutline
    var RotationState : RotationState
    var blockSize: CGFloat = 40
    var centerPosition: CGPoint {
        let pieceWidth = CGFloat(outline.size.width)
        let pieceHeight = CGFloat(outline.size.height)
        
        let centerX = CGFloat(position.x) + (pieceWidth / 2 * blockSize)
        let centerY = CGFloat(position.y) + (pieceHeight / 2 * blockSize)
        
        return CGPoint(x: centerX, y: centerY)
    }
    
}

struct RotationState: Codable {
    var x: Int = 0
    var y: Int = 0
    var z: Int = 0
    
    mutating func rotateZ() {
        z = (z + 1) % 4
    }
    
    mutating func rotateX() {
        x = (x + 1) % 2
    }
    
    mutating func rotateY() {
        y = (y + 1) % 2
    }
}



struct Game: Codable {
    var leftPuzzles: [String] = []
    var rightPuzzles: [String] = []
    var pentominoPieces: [Piece] = []
    var pentominoOutlines: [PentominoOutline] = []
    var puzzleOutlines: [PuzzleOutline] = []
    var solutions: [String: [String: Solution]] = [:]
    var currentPuzzleOutline: [PuzzleOutline] = []
    var gridWidth: CGFloat = 560
    var gridHeight: CGFloat = 560
    var gridRows: Int = 14
    var gridColumns: Int = 14
    var solveDisabled = true
}

