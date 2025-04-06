//
//  GridShape.swift
//  Pentominoes
//
//  Created by Tej Patel on 23/09/24.
//

import SwiftUI

struct GridShape: Shape {
    var rows: Int
    var columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowHeight = rect.height / CGFloat(rows)
        let columnWidth = rect.width / CGFloat(columns)
        
        for row in 0...rows {
            let yPosition = CGFloat(row) * rowHeight
            path.move(to: CGPoint(x: 0, y: yPosition))
            path.addLine(to: CGPoint(x: rect.width, y: yPosition))
        }
        
        for column in 0...columns {
            let xPosition = CGFloat(column) * columnWidth
            path.move(to: CGPoint(x: xPosition, y: 0))
            path.addLine(to: CGPoint(x: xPosition, y: rect.height))
        }
        
        return path
    }
}

struct GridShapeView: View {
    var rows: Int
    var columns: Int
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Color.white
            
            GridShape(rows: rows, columns: columns)
                .stroke(Color.black, lineWidth: 1)
        }
        .frame(width: width, height: height)
    }
}
