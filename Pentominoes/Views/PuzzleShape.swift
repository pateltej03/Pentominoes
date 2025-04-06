//
//  PuzzleShape.swift
//  Pentominoes
//
//  Created by Tej Patel on 23/09/24.
//

import Foundation
import SwiftUI

struct PuzzleShape: Shape {
    var outline: PuzzleOutline
    let width: CGFloat
    let height: CGFloat
    let rows: Int
    let columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let gridCellWidth = rect.width / CGFloat(columns)
        let gridCellHeight = rect.height / CGFloat(rows)
        
        let offsetX = (columns - outline.size.width) / 2
        let offsetY = (rows - outline.size.height) / 2
        
        func drawOutline(_ outline: Outline, in path: inout Path) {
            var isFirst = true
            for point in outline {
                let x = CGFloat(point.x + offsetX) * gridCellWidth
                let y = CGFloat(point.y + offsetY) * gridCellHeight
                
                if isFirst {
                    path.move(to: CGPoint(x: x, y: y))
                    isFirst = false
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            path.closeSubpath()
        }
        
        drawOutline(outline.outlines[0], in: &path)
        
        return path
    }
}


struct PuzzleViewWithHoles: View {
    @Environment(GameManager.self) var manager
    var outline: PuzzleOutline
    
    var whiteOutlines: [Outline] {
        return Array(outline.outlines.dropFirst())
    }
    
    var body: some View {
        ZStack {
            
            let offsetX = (manager.game.gridColumns - outline.size.width) / 2
            let offsetY = (manager.game.gridRows - outline.size.height) / 2
            let width = (manager.game.gridWidth)
            let height = (manager.game.gridHeight)
            let rows = (manager.game.gridRows)
            let columns = (manager.game.gridColumns)
            let widthOverColumn = (width / CGFloat(columns))
            let heightOverRows = (height / CGFloat(rows))
            
            PuzzleShape(outline: outline, width: width, height: height, rows: rows, columns: columns)
                .fill(Color.gray.opacity(0.5))
            
            ForEach(whiteOutlines.indices, id: \.self) { index in
                Path { path in
                    var isFirst = true
                    for point in whiteOutlines[index] {
                        let x = CGFloat(point.x + offsetX) * widthOverColumn
                        let y = CGFloat(point.y + offsetY) * heightOverRows
                        
                        if isFirst {
                            path.move(to: CGPoint(x: x, y: y))
                            isFirst = false
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    path.closeSubpath()
                }
                .fill(Color.white)
                
            }
        }
        .frame(width: manager.game.gridWidth, height: manager.game.gridHeight)
    }
}
