//
//  Shapes.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 12.10.2022.
//

import SwiftUI

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y:100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
}

struct CShape2: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y:100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}
