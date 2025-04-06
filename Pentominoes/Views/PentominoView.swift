//
//  PentominoView.swift
//  Pentominoes
//
//  Created by Tej Patel on 23/09/24.
//

import Foundation
import SwiftUI

struct PentominoView: View {
    var outline: PentominoOutline
    var color: Color
    
    var body: some View {
        ZStack {
            PentominoShape(outline: outline)
                .fill(color)
            
            GridShape(rows: outline.size.height, columns: outline.size.width)
                .stroke(Color.black, lineWidth: 1)
                .clipShape(PentominoShape(outline: outline))
        }
        .frame(width: CGFloat(outline.size.width) * 40, height: CGFloat(outline.size.height) * 40) 
    }
}

struct PentominoShape: Shape {
    var outline: PentominoOutline
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var first = true
        
        let blockWidth = rect.width / CGFloat(outline.size.width)
        let blockHeight = rect.height / CGFloat(outline.size.height)
        
        for point in outline.outline {
            let x = CGFloat(point.x) * blockWidth
            let y = CGFloat(point.y) * blockHeight
            if first == true {
                path.move(to: CGPoint(x: x, y: y))
                first = false
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}
